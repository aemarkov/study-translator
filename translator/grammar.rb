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
  def initialize (right, left) 
    @right=right
    @left=left
  end

  attr_reader :right, :left

  # #Геттеры
  # def right
  #   return @right
  # end

  # def left
  #   return @left
  # end

  #Преобразование к строке
  def to_s
    str="#{@right} ::= "
    @left.each{|lexem| str+="#{lexem} "}
    return str
  end

end

#----------------------------------------------------
# Класс Item хранит пункт грамматики
# Пункт состоит из правила и позиции в этом правиле
class Item

  #Конструктор
  def initialize (rule, position)
    @rule=rule
    @position=position
  end

  attr_reader :rule
  attr_accessor :position

end
#----------------------------------------------------
# Класс Grammar хранит грамматику языка - список 
# терминалов, нетерминалов и правил вывода
# Предоставляет доступ к ним
#----------------------------------------------------
class Grammar

  # Конструктор
  # filename - файл с грамматикой
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
      
      while line[/<.+?>|".+?"/]!=nil
        #Терминал или нетерминал
        word = line[/<.+?>|".+?"/]

        #он же, но без <> или ""
        str=word[1, word.length-2]

        if word[0]=='<'
          #Нетерминал
          right<<@nonterminals[str]
        else
          #Терминал
          right<<@terminals[str]
        end
        
        #Стираем слово
        line[/<.+?>|".+?"/]=""
      end

      #Создаем правило
      rules<<Rule.new(@nonterminals[left], right)

      i+=1
    end

  end

  attr_reader :terminals, :nonterminals, :rules

  #FIRST - множество сииволов грамматики порождаемое symbol
  def first(symbol)

    firstArray=Array(0)

    if symbol.wtfIsIt==0
      #Нетерминал - ищем все сиволы, с которых начинаются правые части правил

      #Просматриваем все правила
      @rules.each{|rule|
        if rule.left==symbol
          #Правило имеет в левой части введенный символ

          firstArray+=first(rule.right[0])

        end
      }
    else
      #Терминал
      firstArray<<symbol
    end

    return firstArray

  end

  #Замыкание
  def closure(items)
    items.each do |item|

      #Если точка не стоит после последнего элемента
      if item.position < item.rule.right.length

        #Элемент правила после точки:
        b=item.rule.left[item.position]

        #Если этот элемент нетерминал
        if b.wtfIsIt==0

          #Все правила, в левой части которых b
          @rule.each do |rule|

            #Если очередное правило имеет в правой части b
            if rule.left.compare(b)
              #Нам тут нужен FIRST
            end

          end

        end
      end
    end
  end

  #------------ PRIVATE -----------------------------
  private


end