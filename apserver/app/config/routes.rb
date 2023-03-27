Rails.application.routes.draw do
  root "index#index"
  namespace 'api' do
    resources :todos, only:[:index] do
    end
  end
end
