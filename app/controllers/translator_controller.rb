require_relative 'translator/grammar'
require_relative 'translator/lexem'
require_relative 'translator/lexer'
require_relative 'translator/parser'

class TranslatorController < ApplicationController

  def index

  end

  def translate

  	#Код программы на милане
  	sourceCode=params[:sourcecode]

  	grammar = Grammar.new('milan_grammar.txt', 'c_grammar.txt')
	  parser = Parser.new(grammar)

	  lexer=Lexer.new(sourceCode , grammar.terminals)
	  lexems, variables, numericConsts, stringConsts = lexer.parse

	  result = parser.parse(lexems, variables, numericConsts, stringConsts)

  	render inline: result
  end
end
