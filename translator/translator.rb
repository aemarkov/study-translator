require_relative 'lexem'
#require_relative 'grammar'
require_relative 'lexer'
require_relative 'parser'


#Список лексем (нетерминалов)
lexemsList=
  {
    "begin"   => [1,0],
    "end"     => [2,0],
    "if"      => [3,0],
    "then"    => [4,0],
    "else"    => [5,0],
    "while"   => [6,0],
    "do"      => [7,0],
    "for"     => [8,0],
    "to"      => [9, 0],
    "read"    => [10,0],
    "write"   => [11,0],
    "var"     => [12,0],
    "and"     => [13,0],
    "or"      => [14,0],
    "integer" => [15,0],
    "string"  => [16,0],
    ";"       => [20,0],
    "="       => [21,0],
    "<>"      => [21,1],
    "<"       => [21,2],
    ">"       => [21,3],
    "<="      => [21,4],
    ">="      => [21,5],
    "+"       => [22,0],
    "-"       => [22,1],
    "*"       => [23,0],
    "/"       => [23,1],
    ":="      => [24,0],
    "("       => [25,0],
    ")"       => [26,0],
    ":"       => [27,0],
    "."       => [28,0],
    ","       => [29,0]
  }

lexer=Lexer.new("
var a, b : integer
begin
  a:=1;
  b:=2;
  write('Lol');
  write(a+b);
end.", lexemsList)
puts lexer.parse