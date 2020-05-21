Rails.application.routes.draw do
  root to: "search_engines#index"

  resources :search_engines
end
