Rails.application.routes.draw do
  resources :notas
  resources :alumnos do
    member do
      get "notas"
    end
  end
  resources :cursos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "home#index"
end
