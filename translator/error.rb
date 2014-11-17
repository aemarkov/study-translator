#--------------------------------------
# Класс, представляющий ошибку
#--------------------------------------
class Error

	#Конструктор
		#errorCode - числовой код ошибки
		#errorDescription - описание ошибки
	def initialize(errorCode, errorDescription)
		@errorCode=errorCode
		@errorDescription=errorDescription
	end

	attr_reader :errorCode, :errorDescription

	#Приведение к строке
	def to_s
		return "Error #{@errorCode}: #{@errorDescription}"
	end



end
