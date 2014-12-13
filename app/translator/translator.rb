require_relative 'grammar'
require_relative 'lexem'
require_relative 'lexer'
require_relative 'parser'



grammar = Grammar.new('milan_grammar.rb', 'c_grammar.txt')
parser = Parser.new(grammar)

puts grammar.destGrammar

lexer=Lexer.new("var a b: integer; begin read(a); read(b); if a<b then write('A<B') end." , grammar.terminals)
lexems, variables, numericConsts, stringConsts = lexer.parse

#parser.parse(lexems, variables, numericConsts, stringConsts)