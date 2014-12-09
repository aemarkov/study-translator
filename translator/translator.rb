require_relative 'lexem'
require_relative 'grammar'
require_relative 'lexer'
require_relative 'parser'



grammar = Grammar.new('milan_grammar.rb', 'c_grammar.txt')
parser = Parser.new(grammar)

#puts grammar.rules

lexer=Lexer.new("3=3 and 2=2" , grammar.terminals)
lexems, variables, numericConsts, stringConsts = lexer.parse

#parser.parse(lexems, variables, numericConsts, stringConsts)

#3<4 and 'a'='b'