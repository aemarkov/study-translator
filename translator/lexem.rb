#----------------------------------------------------------
#Базовая лексема
#Хранит класс и идентификатор
#Сравнивает лексемы по классу и идентификатору
#Приводит к строке
#----------------------------------------------------------
class Lexem

  #Конструктор
  # param[in] type - тип лексемы
  # param[in] id - индекс лексемы в таблице
  # Значение (используется при генерации кода)
  def initialize(type, id, value)
    @type=type
    @id = id
    @value = value
  end

  attr_reader :type, :id
  attr_accessor :value

  #Терминал или нетерминал
  # result - 0 значи терминал
  def wtfIsIt
    return 0
  end

  #Сравнение по содержимому
  # param[in] other - объект, с которым происходит сравнение
  # result - true, если тип и идентификатор совпадают
  def compare(other)
    return (other.type==@type) && (other.id==@id)
  end  

  #Сравнивает только тип. Нужно для сравнения при определении подходящих правил, т.к в некоторых
  #используется один терминал на несколько реальных терминалов (например, < = > <= >=)
  # param[in] other - объект, с которым происходит сравнение
  # result - true, если тип  совпадает
  def compareType(other)
    return other.type==@type
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
  # param[in] type - тип лексемы
  # param[in] id - индекс лексемы в таблице
  # param[in] pos - положение в исходном коде
  # param[in] string - строковое представление лексемы
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