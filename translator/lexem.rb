
#
#Лексема
#Хранит класс, идентификатор и текстовое значение лексемы (или нетерминала)
#Представляет методы для сравнения и приведение лексем к строке
#
class Lexem
  include Comparable

  #Конструктор
    #type - тип лексемы
    #id - индекс лексемы в таблице
    #index - положение в исходном коде
  def initialize(type, id, pos, string)
    @type=type
    @id = id
    @pos = pos
    @str=string
  end

  #получить тип лексемы
  def type
    return @type
  end

  #получить индекс лексемы
  def id
    return @id
  end

  #получить позицию лексемы в тексте
  def pos
    return @pos
  end

  #задать позицию лексемы в тексте
  def pos=(pos)
    @pos=pos
  end

  #сравнение позиции
  def <=>(right)
    return @pos<=>right.pos
  end

  #Сравнение по содержимому
  def compare(other)
    return (other.type==@type) && (other.id==@id)
  end  


  #to string
  def to_s
    return "(#{@str} #{@type}, #{@id})"
  end
end