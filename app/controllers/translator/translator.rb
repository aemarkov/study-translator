require_relative 'grammar'
require_relative 'lexem'
require_relative 'lexer'
require_relative 'parser'



grammar = Grammar.new('milan_grammar.txt', 'c_grammar.txt')
parser = Parser.new(grammar)

#puts grammar.destGrammar

lexer=Lexer.new("var a:integer;
begin
read(a)
end." , grammar.terminals)
lexems, variables, numericConsts, stringConsts = lexer.parse

puts parser.parse(lexems, variables, numericConsts, stringConsts)