Rails.application.routes.draw do
  root "index#index"
  namespace 'api' do
    resources :todos, only:[:index, :show, :create, :destroy, :update] do
    end
  end
end
