require_relative 'lexem'

#
#Осуществляет синтаксический разбор программы
#
class Parser
    
  #В конструктор передается программа и грамматика
  # param[in] lexems - массив лексем - программа
  # param[in] rules - правила вывода
  def initialize (lexems, grammar)
    @lexems=lexems
    @grammar=grammar
    
    #Инициализируем стек
    @stack=Array.new(0)
    
    #Инициализируем массив цепочки вывода
    @inferencing = Array.new(0)
    
    #Номер читаемой лексемы
    @curLexem=0
   
  end
  
  #Осуществляет синтаксический разбор
  def parse
    
  end
  
end