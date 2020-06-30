Rails.application.routes.draw do

  root :to => 'messages#index'

  resources :messages do
    member do
      post :request_prescription
    end
  end

end
