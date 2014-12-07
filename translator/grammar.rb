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
  def initialize (left, right) 
    @right=right
    @left=left
  end

  attr_reader :right, :left

  #Преобразование к строке
  def to_s
    str="#{@left} ::= "
    @right.each{|lexem| str+="#{lexem} "}
    return str
  end

end

#----------------------------------------------------
# Класс Grammar хранит грамматику языка - список 
# терминалов, нетерминалов и правил вывода
# Предоставляет доступ к ним
#----------------------------------------------------
class Grammar

  # Конструктор
  # param[in] - filename - файл с грамматикой
  def initialize(filename)

    @terminals=Hash.new
    @nonterminals=Hash.new
    @rules=Array.new(0)

    #Читаем файл
    lines=IO.readlines(filename)

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
      @terminals[term]=Lexem.new(type, id)
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
      @nonterminals[term]=Lexem.new(type, id)
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

      #Создаем правило
      rules<<Rule.new(@nonterminals[left], right)
      #puts ""

      i+=1
    end

  end

  #Ищет правило вывода, сопадающее с вершиной стека
    # param[in] stack - стек терминалов и нетерминалов
    # param[in] nexWord - следующее слово (на 1 впереди перед словом на верхушке стека)
    # result1 - наиболее подходящее правило, или nil если такового нет
    # result2 - true, если правило завершено и нужна свертка, false - если нужен перенос
  def findRule(stack, nextWord)
    #Копия стека
    stack2=stack.clone
    stack2<<nextWord

    puts 'stack1'
    puts stack
    maxLen1, maxRule1, isFull1 = _findRule(stack, true)

    maxLen2, maxRule2, isFull2 = _findRule(stack2, false)

    puts "1: #{maxLen1}, #{maxRule1}, #{isFull1}"
    puts ''

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
  attr_reader :terminals, :nonterminals, :rules

  #------------ PRIVATE -----------------------------
  private

  #Ищет правило вывода, сопадающее с вершиной стека
    # param[in] stack - стек терминалов и нетерминалов
    # param[in] fullFind - true - искать максимальный процент совпадения, false - максимальную длину совпадения
    # result1 - правило
    # result2 - правило целиком или нет (для принятия решения - перенос или свертка)
  def _findRule(stack, fullFind)
    maxLen=0                  #Длина наиболее совпадающего правила
    maxRule=nil               #Самое длинное совпадающее правило

    maxFullLen=0
    maxFullRule=nil

    #puts stack

    #Проходим по всем правилам
    @rules.each do |rule|

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
      if len>maxLen
        maxLen=len
        maxRule=rule
      end

      if fullFind && (len==rule.right.length)&& (len>maxFullLen)
        maxFullLen=len
        maxFullRule=rule
      end
    end

    #Определяем, находится ли в стеке правило целиком, либо только часть
    if !fullFind || (maxFullRule==nil)
      full=(maxRule!=nil) && (maxRule.right.length == maxLen)
      return maxLen, maxRule, full
    else
      return maxFullLen, maxFullRule, true
    end


  end

end