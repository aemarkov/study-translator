#=========================ВАЖНОЕ ЗАМЕЧАНИЕ=====================================
#При сравнении лексем и нетерминалов сравнивается КЛАСС
#Нетеримналы "отн.", "+-", "*/" кодируются одним КЛАССОМ, но разными ИНДЕКСАМИ
#Поэтому сравнение на основе КЛАССА, а при использовании учитывается ИНДЕКС!
#==============================================================================

#----------------------------------------------------
# Класс Rule хранит правило вывода грамматики
# Лексему левой части и массив лексем левой части
# ---------------------------------------------------
class Rule

  #Конструктор
  #param[in] left - левая часть правила, нетерминал
  #param[in] right - правая часть правила, масссив нетерминалов и терминалов
  #param[in] reqMode - в каком режиме может применяться это правило (0 - любой)
  #param[in] mode - в какой режим происходит переход при успешной свертке правила (0 - перехода нет)
  def initialize (left, right, reqMode, mode) 
    @right=right
    @left=left
    @reqMode=reqMode
    @mode = mode
  end

  attr_reader :right, :left, :reqMode, :mode

  #Преобразование к строке
  def to_s
    str="#{@left} ::= "
    @right.each{|lexem| str+="#{lexem} "}
    str+="#{@reqMode}-#{@mode}"
    return str
  end

end

#----------------------------------------------------
# Класс TargetRule хранит правило целевого языка
# Массив текста и номера вставок, которые заменяются на 
# Значения нетерминалов
#----------------------------------------------------
class TargetRule

  #Конструктор
  #param[in] data - грамматика
  #param[in] length - число вставок
  def initialize (data, length)
    @data=data
    @length=length
  end

  def to_s
    str="length=#{@length}\n"
    str+=@data.to_s
    return str
  end

  attr_reader :data, :length

end


#----------------------------------------------------
# Класс Grammar хранит грамматику языка - список 
# терминалов, нетерминалов и правил вывода
# Предоставляет доступ к ним
#----------------------------------------------------
class Grammar

  # Конструктор
  # param[in] - filenameSource - файл с грамматикой исходного языка
  # param[in] - filenameDest - файл с грамматикой целевого языка
  def initialize(filenameSource, filenameDest)

    @terminals=Hash.new
    @nonterminals=Hash.new
    @rules=Array.new(0)

    #Читаем файл
    lines=IO.readlines(filenameSource)

    i=0

    #Терминалы
    while (i<lines.length) && (lines[i].length!=1)
      
      line=lines[i]

      #Находим значения
      term = line[0, line.index(/ +/)]
      num=line[/[0-9]+/]
      type=num.to_i
      line=''
      num=line[/[0-9]+/]
      id=num.to_i
      
      #Добавляем значения в хэш терминалов
      @terminals[term]=Lexem.new(type, id, '')
      i+=1
    end

    i+=1

    #Нетерминалы
    while (i<lines.length) && (lines[i].length!=1)
      line=lines[i]

      #Находим значения
      term = line[0, line.index(/ +/)]
      num=line[/[0-9]+/]
      type=num.to_i
      line=''
      num=line[/[0-9]+/]
      id=num.to_i
      
      #Добавляем значения в хэш терминалов
      @nonterminals[term]=Lexem.new(type, id, '')
      i+=1
    end

    i+=1

    #Правила вывода
    while (i<lines.length) && (lines[i].length!=1)
      line=lines[i]

      #Находим левую часть правила
      left=line[/[A-z]+/]

      #Вырезаем все, вполть до правой части правила
      line[/.+::= +/]=''

      #Создаем массив правой части
      right=Array.new(0)

      #print "#{left}/#{@nonterminals[left]} ::= "
      
      while line[/<.+?>|".+?"/]!=nil
        #Терминал или нетерминал
        word = line[/<.+?>|".+?"/]

        #он же, но без <> или ""
        str=word[1, word.length-2]

        if word[0]=='<'
          #Нетерминал
          right<<@nonterminals[str]
          #print "#{word}/#{@nonterminals[str]} "
        else
          #Терминал
          right<<@terminals[str]
          #print "#{word}/#{@terminals[str]} "
        end
        
        #Стираем слово
        line[/<.+?>|".+?"/]=""
      end

      #Вырезаем пробелы до режимов
      line[/\s*/]=''

      #Требуемый режим
      reqMode = line[/[0-9]+/]

      line[/[0-9]+/]=''
      line[/\s*/]=''

      #Переход в режим
      mode=line

      #Создаем правило
      rules<<Rule.new(@nonterminals[left], right, reqMode.to_i, mode.to_i)
      #puts ""

      i+=1
    end


    #-------- СЧИТЫВАНИЕ ГРАММАТИКИ С ----------------
    #Создаем массив, где будует хранится целевая грамматика
    @destGrammar=Array.new

    #Читаем файл
    #Записи в файле отделены строками: пустая строка,"N:" (N-номер правила)

    lines=IO.readlines(filenameDest)
    i=-1
    string = ""

    regexp = /[0-9]:/
    lines.each_index do |index|

      if(regexp.match(lines[index]) != nil) && ((index==0) || (lines[index-1].length==1))
        #Если это строка с номером правила, перед которой идет пустая строка
        #Увеличить номер правила (номер правила в файле не используются, чисто для удобства чтения)
        i+=1
        string = ""

      elsif (index<lines.length) && !((lines[index].length==1)&&(regexp.match(lines[index+1]))) && (regexp.match(lines[index])==nil)
        #Если это просто строки файла, а не строка с номером файла
        #Дописать правило в буферную строку
        string+=lines[index]

      else
        #Если это пустая строка перед номером правила
        #Распарсить строку и записать в массив
        @destGrammar<<_separate(string)
      end  
    end

    #Распарсить и записать в массив последнее правило
    @destGrammar<<_separate(string)

    #puts @destGrammar

  end

  #Ищет правило вывода, сопадающее с вершиной стека
    # param[in] stack - стек терминалов и нетерминалов
    # param[in] nexWord - следующее слово (на 1 впереди перед словом на верхушке стека)
    # param[in] mode - текущий режим
    # result1 - наиболее подходящее правило, или nil если такового нет
    # result2 - true, если правило завершено и нужна свертка, false - если нужен перенос
  def findRule(stack, nextWord, mode)
    #Копия стека
    stack2=stack.clone
    stack2<<nextWord

    puts 'stack1'
    puts stack
    maxLen1, maxRule1, isFull1 = _findRule(stack, true, mode)

    puts "1: #{maxLen1}, #{maxRule1}, #{isFull1}"
    puts ''

    maxLen2, maxRule2, isFull2 = _findRule(stack2, false, mode)

    puts 'stack2'
    puts stack2
    puts "2: #{maxLen2}, #{maxRule2}, #{isFull2}"


    if maxLen1>=maxLen2 #|| ((maxLen1>=maxLen2) && (!isFull2))
      return maxRule1, isFull1
    elsif maxLen1>0
      return maxRule2, false
    else
      return nil, false
    end

  end

  #Доступ к полям
  attr_reader :terminals, :nonterminals, :rules, :destGrammar

  #------------ PRIVATE -----------------------------
  private

  #Разделяет строку правила целевого языка на массив подстрок
  def _separate(string)
    str=""              #Строка аккумулятор
    mode=0              #Текущее состояние
    result = Array.new  #Результирующий массив
    bufer = Array.new
    i=0                 #Текущий индекс строки

    regexp = /[0-9]/    #Для проверки на цифру
    length = 0          #Число вставок

    while i<string.length

      #puts string[i]
      #Читается последовательность до вставки
      if(mode==0) && (string[i]!='@') && (string[i]!='|')
        str+=string[i]

      #Последовательность может состоять из несколкьих альтернатив
      #Разделенных символом |
      elsif (mode==0) && (string[i]=='|')
        if(str.length>0)
          bufer<<str
          str=""
        end

      #Символ встатвки, сохраняем последовательность, считанную ранее
      #И считываем вставку
      elsif(mode==0)&&(string[i]=='@')

        if str.length>0
          bufer<<str
          result<<bufer
        end

        mode=1
        bufer=Array.new
        str=""

      #Считываем вставку
      elsif (mode==1)&&(regexp.match(string[i])!=nil)
        str+=string[i]

      #Конец вставки
      elsif(mode==1)&&(regexp.match(string[i])==nil)
        if str.length>0
          result<<str.to_i
          length+=1
        end

        mode=0
        str=""
      end

      i+=1
    end

    #Сохранение последней записи, которая пришлась на конец строки
    #И не вошла в условие @
    if str.length>0
      bufer<<str
      result << bufer
    end

    return TargetRule.new(result, length)
  end


  #Ищет правило вывода, сопадающее с вершиной стека
    # param[in] stack - стек терминалов и нетерминалов
    # param[in] fullFind - true - искать максимальный процент совпадения, false - максимальную длину совпадения
    # param[in] mode - текущий режим
    # result1 - правило
    # result2 - правило целиком или нет (для принятия решения - перенос или свертка)
  def _findRule(stack, fullFind, mode)
    maxLen=0                  #Длина наиболее совпадающего правила
    maxRule=nil               #Самое длинное совпадающее правило

    maxFullLen=0
    maxFullRule=nil

    #puts stack

    #Проходим по всем правилам
    @rules.each_index do |rule_index|

      rule=@rules[rule_index]

      len = 0                 #Длина совпадающей части правила
      i=-1                    #Позиция в  правиле
      j=-1                    #Позиция в стеке

      #Определяем, сколько слов с верщины стека совпадают со словами из правой части
      while (rule.right[i]!=nil) and (stack[j]!=nil)

        #Определяем длину совпадающей части
        if rule.right[i].compareType(stack[j])
          j-=1
          len+=1
        else
          j=-1
          len=0
        end

        i-=1;
      end

      #Сравниваем с макс. длиной и обновляем её
      isGoodMode = (rule.reqMode==mode) || (rule.reqMode==0)  #Подходящий ли режим

      if isGoodMode && (len>maxLen)
        maxLen=len
        maxRule=rule_index
      end

      if fullFind && isGoodMode && (len==rule.right.length)&& (len>maxFullLen)
        maxFullLen=len
        maxFullRule=rule_index
      end
    end

    #УЛЬТРАКОСТЫЛЬ!!!!!!
    #puts "maxRule=#{maxRule}, #{stack[-1]}"
    if !fullFind && (maxRule==5) && (stack[-1].type==30)
      #puts "AZAZA!!!!!!!!!!!!!!!!!!!"
      return 3, 2, false
    end

    #Определяем, находится ли в стеке правило целиком, либо только часть
    if !fullFind || (maxFullRule==nil)
      full=(maxRule!=nil) && (@rules[maxRule].right.length == maxLen)
      return maxLen, maxRule, full
    else
      return maxFullLen, maxFullRule, true
    end


  end

end