require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :folders, only: [:index, :show, :create, :update, :destroy] do
        resources :bookmarks, only: [:index, :create, :update, :destroy]
      end
    end
  end
end
