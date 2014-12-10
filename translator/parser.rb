require_relative 'lexem'

#
#Осуществляет синтаксический разбор программы
#Принимает на вход грамматику и последовательность лексем от лексического анализатора
#Осуществляет последовательность сверток исходной последовательности до начального нетерминала
#(Восходящий анализ)
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
  def parse (text, variables, numericConsts, stringConsts)
    
    #Инициализируем стек
    stack=Array.new(0)

    #Задаем начальный режим
    mode = 1

    #Проходим по всем лексемам из входного потока

    text.each_index do |index|

      #Добавляем лексему в стек
      stack<<text[index]
      puts "--stack:--"
      puts stack
      puts " "

      begin
        isReduced=false
        #Находим подходящее правило свертки
        rule_index, isFull=@grammar.findRule(stack, text[index+1], mode)

        if rule_index!=nil
          rule = @grammar.rules[rule_index]
  
          if isFull

            puts "Reduce: #{rule}"

            #Создаем строку на целевом языке
            destRule = @grammar.destGrammar[rule_index]
            innerValue= ''      #Значение, которое будет сформированно
            pasteIndex=0        #Индекс вставки

            #puts ""
            #puts destRule

            destRule.data.each do |word|

              #puts rule

              if word.class==Array
                #Просто текст
                innerValue+=word[0]
              else
                #Значение предыдущего нетерминала
                #puts "#{word}, nonterm: #{stack[-rule.right.length+word]}"
                innerValue+=stack[-rule.right.length+word].value
              end
            end

            #puts "..."
            #puts innerValue
            #puts "---"

            #Сворачиваем правило
            #Извлекаем из стека лексемы правой части
            rule.right.length.times{|i| stack.pop}

            #Добавляем в стек левую часть правила
            stack << Lexem.new(rule.left.type, rule.left.id, innerValue)

            #Меняем режим
            if rule.mode!=0
              mode=rule.mode
            end

            isReduced=true
            puts "---"
          end
      end
     end while isReduced==true

    end

    puts ""
    puts "fin stack"
    puts stack
    puts ""
    puts "prog"
    puts stack[0].value

  end
  
end