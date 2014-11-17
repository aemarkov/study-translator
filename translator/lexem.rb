#----------------------------------------------------------
#Базовая лексема
#Хранит класс и идентификатор
#Сравнивает лексемы по классу и идентификатору
#Приводит к строке
#----------------------------------------------------------
class Lexem

  #Конструктор
    #type - тип лексемы
    #id - индекс лексемы в таблице
  def initialize(type, id)
    @type=type
    @id = id
  end

  attr_reader :type, :id

  #Терминал или нетерминал
  def wtfIsIt
    return 0
  end

  #Сравнение по содержимому
  def compare(other)
    return (other.type==@type) && (other.id==@id)
  end  

  #to string
  def to_s
    return "<#{@type}, #{@id}>"
  end

end


#-------------------------------------------------------------------
#Терминал
#Хранит класс, идентификатор и текстовое значение
#Представляет методы для сравнения и приведение лексем к строке
#-------------------------------------------------------------------
class Terminal < Lexem
  include Comparable

  #Конструктор
    #type - тип лексемы
    #id - индекс лексемы в таблице
    #pos - положение в исходном коде
    #string - строковое представление лексемы
  def initialize(type, id, pos, string)
    @type=type
    @id = id
    @pos = pos
    @str=string
  end

  attr_accessor :pos

  #Терминал или нетерминал
  def wtfIsIt
    return 1
  end

  #сравнение позиции
  def <=>(right)
    return @pos<=>right.pos
  end

  #to string
  def to_s
    return "('#{@str}', #{@type}, #{@id})"
  end
end