# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.renderer = SimpleNavigation::Renderer::Bootstrap

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :home, t.backend.menu.app_pages, backend_root_path, icon: 'icon-home'
    primary.item :users, t.backend.menu.users, backend_users_path, icon: 'icon-user' if can? :index, User
    primary.item :sign_out, t.actions.sign_out, destroy_user_session_path, method: 'delete', icon: 'icon-off', if: proc { signed_in? }

    primary.dom_id = 'backend_menu'
    primary.dom_class = 'nav'

  end

end
