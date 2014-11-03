#
# Класс, представляющий ошибку
#
class Error

	#Конструктор
		#errorCode - числовой код ошибки
		#errorDescription - описание ошибки
	def initialize(errorCode, errorDescription)
		@errorCode=errorCode
		@errorDescription=errorDescription
	end

	#Геттеры
	def errorCode
		return @errorCode
	end

	def errorDescription
		return @errorDescription
	end

	#Приведение к строке
	def to_s
		return "Error #{@errorCode}: #{@errorDescription}"
	end



end
