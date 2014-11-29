require_relative 'lexem'
require_relative 'grammar'
require_relative 'lexer'
require_relative 'parser'


#Чтение программы из файла
line = IO.readlines("program.txt")
program=""
line.each{|line| program+=line}

grammar = Grammar.new('milan_grammar.rb')
parser = Parser.new(grammar)
lexer=Lexer.new(program, grammar.terminals)

lexems = lexer.parse
#puts lexems

parser.parse(lexems)