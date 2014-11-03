require_relative 'lexem'

#
#Осуществляет синтаксический разбор программы
#
class Parser
  
  #@table - двумерная таблица переходов, индексируется Lexem, на содержит int
  #@rule - массив N*2, [0]-нетерминал левой части, [1]-массив лексем правой части
  
  #В конструктор передается программа и грамматика
  # param[in] lexems - массив лексем - программа
  # param[in] table - таблица переходов
  # param[in] rules - правила вывода
  def initialize (lexems, table, rules)
    @lexems=lexems
    @grammar=grammar
    
    #Инициализируем стек
    @stack=Array.new(0)
    
    #Конечные и начальные нетерминалы
    @stack.push(Lexem(9000, 0, 0, "<END>"))
    @stack.push(Lexem(9001, 0, 0, "<PROGRAM>"))
   
    #Инициализируем массив цепочки вывода
    @inferencing = Array.new(0)
    
    #Номер читаемой лексемы
    @curLexem=0
   
  end
  
  #Осуществляет синтаксический разбор
  def parse
    
    while @stack[-1]!=Lexem(9001, 0, 0, "<END>")
       
       #Если на вершине стека находится такой же нетерминал, как и во входном потоке - 
       #считаем его и уберем из вершины стека
       if(@stack[-1]==@text[@curLexem]) then
         @stack.pop
         @curLexem+=1
       else
         #Находим правило на пересечении вершины стека и нетерминала и применяем его
         #Ну я хз, как сделать двумерный хэш
         #Но допустим, тут делается так
         #@stack=inference(@stack, @rules[@text[@curLexem], @stack[-1]])
       end
    end
    
  end
  
  #Раскрывает нетерминал в вершине стека
  def inference(stack, rule)
    
    #копируем элементы правой части правила в конец стека (начиная с нетерминала, он перезаписывается)
    rule[1].each_index{|i|stack[stack.lenght-1+i]=rule[1][i]}
    return stack
  end
  
end