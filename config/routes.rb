Rails.application.routes.draw do
  resources :notas do
    member do
      post "cerrar"
      get "cierre"
    end
    collection do
      get "top10"
      get "recuperacion"
      get "download"
    end
  end
  resources :alumnos do
    member do
      get "notas"
    end
  end
  resources :cursos do
    member do
      get "notas"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "home#index"

  namespace :api, defaults: {format: :json} do
    namespace :v1 do 
      devise_scope :admin do
        post "register", to: "auth#register"
        post "login", to: "auth#login"
      end
    end
  end
end
