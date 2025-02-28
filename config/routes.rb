Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, format: 'json' do
    resources :spend, only: %i[index create destroy] do
      collection do
        delete 'selected_delete'
      end
    end
    resources :spend_category, only: %i[index create destroy update]
    mount_devise_token_auth_for 'User', at: 'auth'
    get 'test/index'
  end
end
