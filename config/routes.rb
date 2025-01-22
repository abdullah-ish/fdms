Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # devise_for :admin_users, controllers: {
  #   sessions: 'admins/sessions'
  # }
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  resources :financial_reports do
    collection do
      get :select_subdomain
    end
  end
  resources :subdomains, only: [:index, :show] do
    resources :financial_reports do
      resources :investigations, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
        resources :reviews, only: [:index, :new, :create, :show, :update] do
          member do
            patch :approve
          end
        end
      end
      resources :reviews, only: [:index, :new, :create, :show, :update] do
        member do
          patch :approve
        end
      end
    end   
  end
  get '/sw.js', to: proc { [204, {}, []] }, constraints: ->(req) { Rails.env.development? }

  # Defines the root path route ("/")
  root "homes#index"
end