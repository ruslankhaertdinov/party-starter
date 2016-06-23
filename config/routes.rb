Rails.application.routes.draw do
  scope defaults: { format: :json } do
    devise_for :users, only: []
  end

  namespace :v1, defaults: { format: "json" } do
    devise_scope :user do
      post "users/sign_in", to: 'sessions#create'
    end
    resources :events, only: %i(index show create)
    resources :owner_events, only: %i(index)
    resources :availabilities, only: %i(index create)
    resources :event_users, only: %i(create destroy)
    resources :users, only: %i(create)
  end
end
