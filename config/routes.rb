Translator::Application.routes.draw do
  get "help/index"
  get "translator/translate"
  get "register/index"
  get "login/index"
  root 'index#index'
  get "translator/index"
  
end
