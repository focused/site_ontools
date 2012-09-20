# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :home, t.menu.home, root_path

    primary.dom_id = 'main_menu'
    primary.dom_class = 'h_menu'

  end
end
