#=========================ВАЖНОЕ ЗАМЕЧАНИЕ=====================================
#При сравнении лексем и нетерминалов сравнивается КЛАСС
#Нетеримналы "отн.", "+-", "*/" кодируются одним КЛАССОМ, но разными ИНДЕКСАМИ
#Поэтому сравнение на основе КЛАССА, а при использовании учитывается ИНДЕКС!
#==============================================================================


#----------------------------------------------------
# Класс Grammar хранит грамматику языка - список 
# терминалов, нетерминалов и правил вывода
# Предоставляет доступ к ним
# Являеется базовым для классов других грамматик
#----------------------------------------------------
class Grammar

#Без этого не хочет работать
@@terminals={"NULL"=>[0,0]}
@@nonterminals=[0]
@@grammar=[0]

  #Возвращеет список терминалов
  def self.terminals
      return @@terminals
  end

  #Возвращает список нетерминалов
  def self.nonterminals
    return @@nonterminals
  end

  #Возвращает грамматику
  def self.grammar
    return @@grammar
  end
end

#Класс грамматики Милана
class MILAN_Grammar < Grammar

    #Список  терминалов (лексем)
    @@terminals=
    {
      "begin"         => Lexem.new(1,0),
      "end"           => Lexem.new(2,0),
      "if"            => Lexem.new(3,0),
      "then"          => Lexem.new(4,0),
      "else"          => Lexem.new(5,0),
      "while"         => Lexem.new(6,0),
      "do"            => Lexem.new(7,0),
      "for"           => Lexem.new(8,0),
      "to"            => Lexem.new(9, 0),
      "read"          => Lexem.new(10,0),
      "write"         => Lexem.new(11,0),
      "var"           => Lexem.new(12,0),
      "and"           => Lexem.new(13,0),
      "or"            => Lexem.new(14,0),
      "integer"       => Lexem.new(15,0),
      "string"        => Lexem.new(16,0),
      ";"             => Lexem.new(20,0),
      "="             => Lexem.new(21,0),
      "<>"            => Lexem.new(21,1),
      "<"             => Lexem.new(21,2),
      ">"             => Lexem.new(21,3),
      "<="            => Lexem.new(21,4),
      ">="            => Lexem.new(21,5),
      "+"             => Lexem.new(22,0),
      "-"             => Lexem.new(22,1),
      "*"             => Lexem.new(23,0),
      "/"             => Lexem.new(23,1),
      ":="            => Lexem.new(24,0),
      ".new("         => Lexem.new(25,0),
      ")"             => Lexem.new(26,0),
      ":"             => Lexem.new(27,0),
      "."             => Lexem.new(28,0),
      ","             => Lexem.new(29,0),
      #графоуни
      "getcolorrgb"   => Lexem.new(42,0),
      "drawpoint"     => Lexem.new(43,0),
      "drawline"      => Lexem.new(44,0),
      "drawcircle"    => Lexem.new(45,0),
      "getpixelcolor" => Lexem.new(46,0),
      "clrscr"        => Lexem.new(47,0),
      "color"         => Lexem.new(48,0),
      #Это терминалы констант и идентификаторов
      #В явном виде не встречаются в программе
      #Индекс заменяется  индексом соотв. константы\идентификатора в таблицах
      "@id"           => Lexem.new(30,0),
      "@nconst"       => Lexem.new(40,0),
      "@sconst"       => Lexem.new(41,0)
    }

    #Список нетерминалов
    @@nonterminals=
    {
        "program"           => Lexem.new(100,0),     # Стартовый нетерминал
        "var_define"        => Lexem.new(101,0),     # Объявление переменных
        "var_list"          => Lexem.new(102,0),     # Список переменных
        "var_block"         => Lexem.new(103,0),     # Блок переменных
        "names_list"        => Lexem.new(104,0),     # Список имен
        "type"              => Lexem.new(105,0),     # Тип
        "program_body"      => Lexem.new(106,0),     # Тело программы
        "operators_list"    => Lexem.new(107,0),     # Последовательность операвторов
        "operator"          => Lexem.new(108,0),     # Оператор
        "condition"         => Lexem.new(109,0),     # Условие
        "comparation"       => Lexem.new(110,0),     # Сравнение
        "logic_operator"    => Lexem.new(111,0),     # Логический оператор
        "expression"        => Lexem.new(112,0),     # Выражение
        "num_expression"    => Lexem.new(113,0),     # Числовое выражение
        "str_expression"    => Lexem.new(114,0),     # Строковое выражение
        "term"              => Lexem.new(115,0),     # Часть численного выражения
        "multiplier"        => Lexem.new(116,0),     # Множитель
        "str_term"          => Lexem.new(117,0),     # Часть строкового выражения
        "color_expression"  => Lexem.new(118,0),     # Цветовое выражение
        "ending"            => Lexem.new(119,0)      # Конечный нетерминал
    }

    #Грамматика
    @@grammar=
    [
        #Программа целиком
        [@@nonterminals["program"],         [@@nonterminals["var_define"], @@nonterminals["program_body"]]],
        #Объявление переменных
        [@@nonterminals["var_define"],      [@@terminals["var"], @@nonterminals["var_list"]]],
        [@@nonterminals["var_list"],        [@@nonterminals["var_block"], @@terminals[";"], @@nonterminals["var_list"]]],
        [@@nonterminals["var_list"],        [@@nonterminals["var_block"]]],
        [@@nonterminals["var_block"],       [@@nonterminals["names_list"], @@terminals[":"], @@nonterminals["type"]]],
        [@@nonterminals["names_list"],      [@@terminals["@id"]]],
        [@@nonterminals["names_list"],      [@@terminals["@id"],@@terminals[","],@@nonterminals["names_list"]]],
        [@@nonterminals["type"],            [@@terminals["integer"]]],
        [@@nonterminals["type"],            [@@terminals["string"]]],
        [@@nonterminals["type"],            [@@terminals["color"]]],
        #Тело программы
        [@@nonterminals["program_body"],    [@@terminals["begin"], @@nonterminals["operators_list"], @@terminals["end"]]],
        [@@nonterminals["operators_list"],  [@@nonterminals["operator"]]],
        [@@nonterminals["operators_list"],  [@@nonterminals["operator"], @@terminals[";"], @@nonterminals["operators_list"]]],
        [@@nonterminals["operator"],        [@@terminals["@id"], @@terminals[":="], @@nonterminals["expression"]]],
        [@@nonterminals["operator"],        [@@terminals["if"], @@nonterminals["condition"], @@terminals["then"], @@nonterminals["operator"]]],
        [@@nonterminals["operator"],        [@@terminals["if"], @@nonterminals["condition"], @@terminals["then"], @@nonterminals["operator"], @@terminals["else"], @@nonterminals["operator"]]],
        [@@nonterminals["operator"],        [@@terminals["while"], @@nonterminals["condition"], @@terminals["do"], @@nonterminals["operator"]]],
        [@@nonterminals["operator"],        [@@terminals["for"], @@terminals["@id"], @@terminals[":="], @@nonterminals["expression"], @@terminals["to"], @@nonterminals["expression"], @@terminals["do"], @@nonterminals["operator"]]],
        [@@nonterminals["operator"],        [@@terminals["write"], @@terminals["("], @@nonterminals["expression"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["read"], @@terminals["("], @@terminals["@id"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["drawpoint"], @@terminals["("], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["color_expression"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["drawline"], @@terminals["("], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[","], @@terminals[","], @@nonterminals["num_expression"], @@nonterminals["color_expression"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["drawcircle"], @@terminals["("], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["color_expression"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["getpixelcolor"],@@terminals["("],@@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["clrscr"], @@terminals["("], @@nonterminals["color_expression"], @@terminals[")"]]],
        [@@nonterminals["operator"],        [@@terminals["begin"], @@nonterminals["operators_list"], @@terminals["end"]]],
        #Логические операции, сравнения итп
        [@@nonterminals["condition"],       [@@nonterminals["comparation"]]],
        [@@nonterminals["condition"],       [@@nonterminals["comparation"], @@nonterminals["logic_operator"], @@nonterminals["condition"]]],
        [@@nonterminals["comparation"],     [@@nonterminals["expression"], @@terminals["="], @@nonterminals["expression"]]],
        [@@nonterminals["logic_operator"],  [@@terminals["and"]]],
        [@@nonterminals["logic_operator"],  [@@terminals["or"]]],
        #Выражения
        [@@nonterminals["expression"],      [@@nonterminals["num_expression"]]],
        [@@nonterminals["expression"],      [@@nonterminals["str_expression"]]],
        [@@nonterminals["expression"],      [@@nonterminals["color_expression"]]],
        [@@nonterminals["num_expression"],  [@@nonterminals["term"]]],
        [@@nonterminals["num_expression"],  [@@nonterminals["term"], @@terminals["+"], @@nonterminals["num_expression"]]],
        [@@nonterminals["term"],            [@@nonterminals["multiplier"]]],
        [@@nonterminals["term"],            [@@nonterminals["multiplier"], @@terminals["*"], @@nonterminals["term"]]],
        [@@nonterminals["multiplier"],      [@@terminals["@id"]]],
        [@@nonterminals["multiplier"],      [@@terminals["("], @@nonterminals["num_expression"], @@terminals[")"]]],
        [@@nonterminals["multiplier"],      [@@terminals["nconst"]]],
        [@@nonterminals["str_expression"],  [@@nonterminals["str_term"]]],
        [@@nonterminals["str_expression"],  [@@nonterminals["str_term"], @@terminals["+"], @@nonterminals["str_expression"]]],
        [@@nonterminals["str_term"],        [@@terminals["@id"]]],
        [@@nonterminals["str_term"],        [@@terminals["sconst"]]],
        [@@nonterminals["color_expression"],[@@terminals["@id"]]],
        [@@nonterminals["color_expression"],[@@terminals["getcolorrgb"], @@terminals["("], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[","], @@nonterminals["num_expression"], @@terminals[")"]]]
    ]

end