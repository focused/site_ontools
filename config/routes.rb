SiteOne::Application.routes.draw do

  resources :products

  # ----------------------------------------------------------------------------
  # BACKEND
  # ----------------------------------------------------------------------------

  get 'admin' => 'backend/app_pages#index', as: 'admin'
  namespace :backend do
    resources :products
    resources :product_groups
    resources :app_pages, only: 'home'
    resources :users do
      get 'confirm', on: :member
    end
    resources :pages
    resources :page_meta_tags

    root to: "app_pages#index"
  end

  # ----------------------------------------------------------------------------

  #elfinder
  match 'filemanager/:action' => 'file_manager', constraints: { action: /elfinder|browser/ }
  match 'filemanager' => 'file_manager#index'

  scope '(:locale)', constraints: { locale: %r(#{APP[:available_locales] * '|'}) } do
    resources :products, only: %w(show)

    resources :product_groups, only: %w(show)

    # devise
    devise_for :users

    resources :users do
      get 'confirm', on: :member
    end

    # app pages
    get ':action' => 'app_pages', constraints: { action: /home|home_stub/ }, as: 'app_page'

    # custom pages
    match '*path' => 'pages#show', as: :static_page,
      constraints: lambda { |request| APP[:available_locales].exclude?(request.params[:path].to_sym) && (request.url =~ /\.(\w{2,4})$/).nil? }

    root to: 'app_pages#home'
    # root to: "app_pages#home#{Rails.env.production? ? '_stub' : ''}"
  end
end
