Rails.application.routes.draw do
  get "401", to: "errors#unauthorized", as: :unauthorized_error
  get "403", to: "errors#forbidden", as: :forbidden_error
  get "404", to: "errors#not_found", as: :not_found_error
  get "406", to: "errors#not_acceptable", as: :not_acceptable_error
  get "422", to: "errors#unprocessable_entity", as: :unprocessable_entity_error
  get "500", to: "errors#internal_server_error", as: :internal_server_error_error

  namespace :admin do
    resources :pages, only: [] do
      collection do
        get :system
      end
    end

    resources :steps do
      member do
        patch :move_higher
        patch :move_lower
      end
    end

    resources :user_steps do
      member do
        patch :move_higher
        patch :move_lower
      end
    end

    resources :users

    root to: "pages#home"
  end

  resources :guides, only: [:index] do
    collection do
      get :power
      get :shipping_container
    end
  end

  resources :pages, only: [] do
    collection do
      get :contact
      get :history
    end
  end

  resources :steps, only: [:index, :show]

  resources :user_steps, only: [:index, :show, :edit, :update]

  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    omniauth_calbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }

  resources :users, only: [:index, :show]

  root to: "pages#home"
end
