Rails.application.routes.draw do
  resources :notas do
    member do
      post "cerrar"
      get "cierre"
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
end
