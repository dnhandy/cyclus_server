Rails.application.routes.draw do
  resources :query_types
  resources :queries do
      member do
        get :execute
      end
  end

  resources :input_files do
    collection do
      post :refresh
    end

    member do
      get :download
    end
  end

  resources :jobs do
    member do
      get :output_file
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
