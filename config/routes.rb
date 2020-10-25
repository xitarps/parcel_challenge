Rails.application.routes.draw do
  devise_for :admins
  devise_for :requesters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  get 'requester_dashboard', to: 'requester_dashboard#index'
  get 'admin_dashboard', to: 'admin_dashboard#index'

  post 'accept_credit', to: 'credits#update_parcels'

  resources :credits, except: %i[index]
  resources :requesters, only: %i[index show]
end
