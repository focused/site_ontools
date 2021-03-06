# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.renderer = SimpleNavigation::Renderer::Bootstrap

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :resources, t.backend.sidebar.resources, nil, class: 'nav-header'
    primary.item :pages, t.backend.menu.pages, backend_pages_path,
      icon: 'icon-file', highlights_on: :subpath if can? :index, Page
    primary.item :page_meta_tags, t.backend.menu.page_meta_tags, backend_page_meta_tags_path,
      icon: 'icon-globe', highlights_on: :subpath if can? :index, PageMetaTag
    primary.item :product_groups, t.backend.menu.product_groups, backend_product_groups_path,
      icon: 'icon-folder-close', highlights_on: :subpath if can? :index, ProductGroup
    primary.item :products, t.backend.menu.products, backend_products_path,
      icon: 'icon-gift', highlights_on: :subpath if can? :index, Product
    primary.item :fast_orders, t.backend.menu.fast_orders, backend_fast_orders_path,
      icon: 'icon-pencil', highlights_on: :subpath if can? :index, FastOrder

    primary.dom_id = 'backend_side_menu'
    primary.dom_class = 'nav nav-list'

  end

end
