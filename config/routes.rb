Rails.application.routes.draw do
  scope defaults: { format: :json } do
    devise_for :users, only: []
  end

  namespace :v1, defaults: { format: "json" } do
    devise_scope :user do
      post "users/sign_in", to: 'sessions#create'
    end
    resources :events, only: %i(index show create destroy)
    resources :event_users, only: %i(create) do
      delete :destroy, on: :collection
    end
    resources :users, only: %i(create)
    resources :availabilities, only: %i(create)
    get "/availability", to: 'availabilities#show'
  end
end
