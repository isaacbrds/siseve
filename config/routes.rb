Rails.application.routes.draw do
  devise_for :users
  resources :events do
    resources :talks
  end

  # root "posts#index"
end
