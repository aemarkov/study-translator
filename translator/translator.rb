require_relative 'lexem'
require_relative 'grammar'
require_relative 'lexer'
require_relative 'parser'



grammar = Grammar.new('milan_grammar.rb', 'c_grammar.txt')
parser = Parser.new(grammar)

#puts grammar.rules

lexer=Lexer.new("var c:color; begin drawpoint(3,3,getcolorrgb(1,1,1)) end." , grammar.terminals)
lexems, variables, numericConsts, stringConsts = lexer.parse

#puts grammar.destGrammar
parser.parse(lexems, variables, numericConsts, stringConsts)

#3<4 and 'a'='b'