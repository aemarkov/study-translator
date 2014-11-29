require_relative 'lexem'
require_relative 'grammar'
require_relative 'lexer'
require_relative 'parser'

=begin
lexer=Lexer.new("
var
	a, b, c, i: integer;
begin
	read(a);
	read(b);
	c:=1;
	for i:=1 to a do c:=c*b;
	write('a^b='');
	write(c);
end.", grammar.terminals)
=end


grammar = Grammar.new('milan_grammar.rb')
puts grammar.terminals