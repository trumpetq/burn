Rails.application.routes.draw do
  get "401", to: "errors#unauthorized", as: :unauthorized_error
  get "403", to: "errors#forbidden", as: :forbidden_error
  get "404", to: "errors#not_found", as: :not_found_error
  get "406", to: "errors#not_acceptable", as: :not_acceptable_error
  get "422", to: "errors#unprocessable_entity", as: :unprocessable_entity_error
  get "500", to: "errors#internal_server_error", as: :internal_server_error_error

  namespace :admin do
    resource :camp, only: [:show]

    resources :camp_applications do
      member do
        patch :active
        patch :approve
        patch :complete
        delete :force_delete
        patch :reject
        patch :restore
      end
    end

    resources :camp_deposits do
      member do
        patch :active
        patch :complete
        patch :pay
        patch :refund
        patch :reject
        patch :skip
      end
    end

    resources :camp_dues do
      member do
        patch :active
        patch :complete
        patch :pay
        patch :refund
        patch :reject
        patch :skip
      end
    end

    resources :camp_interviews do
      member do
        patch :active
        patch :approve
        patch :assign
        patch :complete
        delete :force_delete
        patch :no_response
        patch :skip
        patch :restore
        patch :reject
      end
    end

    resources :camp_job_definitions do
      member do
        patch :active
      end
    end

    resources :camp_job_descriptions do
      member do
        patch :active
      end
    end

    resources :camp_jobs do
      member do
        patch :active
        patch :approve
        patch :assign
        patch :complete
        patch :skip
        patch :reject
      end
    end

    resources :camp_tickets

    resources :camp_vehicles do
      member do
        patch :active
        patch :approve
        patch :complete
        patch :reject
      end
    end

    resources :camp_work_access_passes do
      member do
        patch :active
        patch :approve
        patch :assign
        patch :reject
        patch :remove_ticket
      end
    end

    resources :newsletters do
      collection do
        get :export
      end

      member do
        delete :force_delete
        patch :restore
        patch :unsubscribe
      end
    end

    resources :pages, only: [] do
      collection do
        get :system
      end
    end

    resources :users do
      collection do
        get :deleted
        get :interviewers
      end

      member do
        patch :remove_avatar
        patch :restore
      end
    end

    root to: "pages#home"
  end

  resources :camp_applications, except: [:destroy] do
    collection do
      get :start
    end
  end

  resources :camp_deposits, except: [:destroy] do
    member do
      patch :pay
    end
  end

  resources :camp_dues, except: [:destroy] do
    member do
      patch :pay
    end
  end

  resources :camp_interviews, only: [:index, :show] do
    member do
      patch :approve_or_reject
    end
  end

  resources :camp_job_definitions, only: [:index, :show]
  resources :camp_job_descriptions, only: [:index, :show]
  resources :camp_jobs

  resources :camp_tickets

  resources :camp_vehicles

  resources :camp_work_access_passes

  resources :guides, only: [:index] do
    collection do
      get :build
      get :bunny_bar
      get :covid
      get :deposit
      get :disclaimer
      get :dues
      get :events
      get :history
      get :ice
      get :interview
      get :jobs
      get :kitchen
      get :lag_bolts
      get :learn
      get :map
      get :mayor_of_the_day
      get :outside_services
      get :parking
      get :power
      get :projects
      get :rules
      get :sauna
      get :shade
      get :shipping_container
      get :sound
      get :strike
      get :tickets
      get :tools
      get :trash
      get :work_access_pass
      get :yearbook
    end
  end

  resources :newsletters do
    member do
      patch :unsubscribe
    end
  end

  resources :pages, only: [] do
    collection do
      get :contact
      get :events
      get :history
    end
  end

  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    omniauth_calbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }

  resources :users, only: [:index, :show, :edit] do
    collection do
      get :me
      get :search
    end
  end

  root to: "pages#home"
end
