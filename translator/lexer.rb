
#-----------------------------------------------------------
#Лексический анализатор
#
#Преобразует текст программы в последовательность лексем
#-----------------------------------------------------------
class Lexer

	#Регулярные выражения
	@@regExpes=[
	/'[^']*'/,		#Строковая константа
	/\d+[A-z]+/,	#Неправильный идентификатор - с цифры
	/[A-z][\w|_]*/,	#Идентификатор
	#/\b\d+\b/,		#Числовая константа
	/-?\d+/,		#Числовая константа
	/:=|<=|>=|<>/,	#составные знаки
	/;|=|<|>|\+|-|\*|\/|\(|\)|\:|\.|,/
	]	

	#Конструктора
		#text -  Исходный текст программы
	def initialize (text, lexemsList)
		@lexems = Array.new(0)
		@text = text
		@lexemsList=lexemsList

		#Инициализируем таблицы переменных, констант и строк
		@variables=Hash.new
		@numericConsts=Hash.new
		@stringConsts=Hash.new
	end

	#Возврашает исходный код
	def code
		return @text
	end


	#Осуществляет разбор текста на лексемы
	def parse

		#Пробегаем по строке всем регулярками
		@@regExpes.each do |regExp|

			#Находим все подстроки, соответствуюшие очредной регулярке
			@text, substr, index = getSubstring(@text, regExp)
			while substr!=nil

				#Определяем лексему
				lexem = getLexem(substr, regExp)
				lexem.pos=index

				#Добавляем лексему в массив
				#Надо не добавлять, а потом сортировать, а сразу вставлять
				#Сложность вставки О(N), сортировки O(NLogN) (???)
				@lexems[@lexems.size]=lexem

				#Получаем новую подстроку с лексемлй
				@text, substr, index = getSubstring(@text, regExp)
			end
		end

		#Сортируем лексемы в порядке следования в строке
		#УБРАТЬ ЭТОТ КОСТЫЛЬ!!!
		@lexems.sort!

		return @lexems
	end

	#---------------------------- PRIVATE ---------------------------------------------------
	private


	#Вырезает подстроку
		#string - текст программы
		#regExp - регуоярное выражение для поиска подстроки
	def getSubstring(string, regExp)

		#Находим первое вхождение совпадающей строки
		substring = string[regExp]

		if substring != nil
			#Заменяем вхождение пробелами
			index = string.index(substring)
			string[substring]=" "*substring.length
		else
			index=nil
		end

		return string, substring, index
	end


	#Определяет лексему
		#string - текст программы
		#regExp - регуоярное выражение для поиска подстроки
	def getLexem(string, regExp)
		return case
			when regExp==@@regExpes[0] then createStrConstLexem(string)
			when regExp==@@regExpes[1] then "invalid const"
			when regExp==@@regExpes[2] then createKeywordLexem(string)
			when regExp==@@regExpes[3] then createNumConstLexem(string)
			when regExp==@@regExpes[4] then createKeywordLexem(string)
			when regExp==@@regExpes[5] then createKeywordLexem(string)				
			else -1
		end

	end

	#Создает лексему оператора
	def createKeywordLexem(string)
		lexem = @lexemsList[string]

		#Является ли идиентфикатор переменной или ключевым словом
		if lexem!=nil
			#Ключевое слово
			return Terminal.new(lexem.type, lexem.id, 0, string)
		else
			#переменная
			return createIdLexem(string)
		end
	end

	#Создает лексему числовой константы
	def createNumConstLexem(string)
		if @numericConsts[string]==nil
			#Константа встречается в  первый раз
			#Добавим в таблицу
			@numericConsts[string]=@numericConsts.size
		end

		#Возвращаем лексему
		return Terminal.new(@lexemsList["@nconst"].type, @numericConsts[string],0, string)
	end

	#создает лексему  строковой константы
	def createStrConstLexem(string)
		if @stringConsts[string]==nil
			#Строка встречается в  первый раз
			#Добавим в таблицу
			@stringConsts[string]=@stringConsts.size
		end

		#Возвращаем лексему
		return Terminal.new(@lexemsList["@sconst"].type, @stringConsts[string],0, string)
	end

	#Создает лексему идентификатора
	def createIdLexem(string)
		if @variables[string]==nil
			#переменная встречается в  первый раз
			#Добавим в таблицу
			@variables[string]=@variables.size
		end

		#Возвращаем лексему
		return Terminal.new(@lexemsList["@id"].type, @variables[string],0, string)
	end


end