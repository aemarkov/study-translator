require_relative 'lexem'
require_relative 'grammar'
require_relative 'lexer'
require_relative 'parser'



grammar = Grammar.new('milan_grammar.rb')
parser = Parser.new(grammar)
#puts grammar.rules

lexer=Lexer.new("read(a)" , grammar.terminals)
lexems = lexer.parse
#puts lexems

parser.parse(lexems)