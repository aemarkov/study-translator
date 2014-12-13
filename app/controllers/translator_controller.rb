class TranslatorController < ApplicationController
  def index
  end
  
  def translate
  	render plain: 'OK'
  end
end
