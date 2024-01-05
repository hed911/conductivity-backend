Rails.application.routes.draw do
  resources :grids, only: %i[index create], defaults: { format: :json } do
    collection do
      get :find_paths
      delete :clear
    end
  end
end
