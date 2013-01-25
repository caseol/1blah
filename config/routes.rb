Botonera::Application.routes.draw do

  resources :contacts

  resources :visits
  resources :categories
  resources :users
  resources :sessions
  resources :articles

  get 'cadastrar', :to => 'users#new', :as => 'signup'
  get 'entrar', :to => 'sessions#new', :as => 'login'
  get 'sair', :to => 'sessions#destroy', :as => 'logout'
  get 'teste', :to => 'application#teste'

  # rotas para melhorar as URLs da aplicação
  match 'contato', :to =>'contacts#new', :as => 'contato', :menu => "contato"
  match 'private', :to =>'buttons#private', :as => 'private', :menu => "private"
  match 'count_visit', :to =>'visits#count_visit', :as => 'count_visit'
  match 'count_play', :to =>'buttons#count_play', :as => 'count_play'
  match 'melhores', :to =>'buttons#best_ever', :as => 'melhores', :menu => "melhores"
  match 'novo_blah', :to =>'buttons#new', :as => 'novo_blah', :menu => "novo_blah"
  match 'view', :to =>'buttons#view', :as => 'view'
  match 'manage_favorite', :to =>'buttons#manage_favorite', :as => 'manage_favorite', :menu => "favoritos"
  match 'favoritos', :to =>'buttons#favorites', :as => 'favoritos', :menu => "favoritos"
  match 'ranking', :to =>'users#ranking', :as => 'ranking', :menu => "ranking"


  # rotas temporárias para executar atualizações nos modelos
  match 'generate_share_code', :to =>'application#generate_share_code'
  match 'update_button_with_share_code', :to =>'application#update_button_with_share_code'
  match 'generate_nickname', :to =>'application#generate_nickname'

  # A ordem deve ser mantida para simular o permalink das categorias na listagem dos botões
  match 'categoria/:category' => 'buttons#index'
  resources :buttons

  root :to => 'buttons#index', :menu => "/"

end
