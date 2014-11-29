require_relative 'lexem'

#
#Осуществляет синтаксический разбор программы
#
class Parser
    
  #В конструктор передается программа и грамматика
  # param[in] lexems - массив лексем - программа
  # param[in] rules - правила вывода
  def initialize (grammar)
    @grammar=grammar
    
    #Номер читаемой лексемы
    @curLexem=0
   
  end
  
  #Осуществляет синтаксический разбор
  def parse (text)
    
    #Инициализируем стек
    stack=Array.new(0)

    #Проходим по всем лексемам из входного потока
    text.each_index do |index|

      #Добавляем лексему в стек
      stack<<text[index]
      puts "--stack:--"
      puts stack
      puts "----------"

      #Находим подходящее правило свертки
      rule, isFull = @grammar.findRule(stack, text[index+1])

      puts "#{rule}, #{isFull}"

      # if rule!=nil
      #   #Сворачиваем правило
      #   #Извлекаем из стека лексемы правой части
      #   rule.right.length.times{|i| stack.pop}

      #   #Добавляем в стек левую часть правила
      #   stack << rule.left

      #   puts "Reduce #{rule}"
      # end

    end

    puts ""
    puts "fin stack"
    puts stack

  end
  
end