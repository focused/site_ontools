# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.renderer = SimpleNavigation::Renderer::Bootstrap

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :resources, t.backend.sidebar.resources, nil, class: 'nav-header'
    primary.item :pages, t.backend.menu.pages, backend_pages_path, icon: 'icon-file' if can? :index, Page
    primary.item :pages, t.backend.menu.page_meta_tags, backend_page_meta_tags_path, icon: 'icon-file' if can? :index, PageMetaTag

    primary.dom_id = 'backend_side_menu'
    primary.dom_class = 'nav nav-list'

  end

end
