Rails.application.routes.draw do
  get "401", to: "errors#unauthorized", as: :unauthorized_error
  get "403", to: "errors#forbidden", as: :forbidden_error
  get "404", to: "errors#not_found", as: :not_found_error
  get "406", to: "errors#not_acceptable", as: :not_acceptable_error
  get "422", to: "errors#unprocessable_entity", as: :unprocessable_entity_error
  get "500", to: "errors#internal_server_error", as: :internal_server_error_error

  resource :pages, only: [] do
    collection do
      get :system
    end
  end

  devise_for :users

  root to: "pages#home"
end
