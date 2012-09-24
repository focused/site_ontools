class ApplicationController < ActionController::Base
  include Extensions::ActionRescue
  include Extensions::ActionLocations

  protect_from_forgery

  # set default meta tags
  before_filter :meta_tags

  # make menu lists for using accross the whole layout
  before_filter :make_menu_lists

  protected

  def meta_tags
    meta = PageMetaTag.by_path(params[:path].to_s)

    set_meta_tags(
      title: (meta.try(:title).present? and !meta.title.nil?) ? meta.title.to_str : t.meta.title,
      description: (meta.try(:description).present? and !meta.description.nil?) ? meta.description.to_str : t.meta.description,
      keywords: (meta.try(:keywords).present? and !meta.keywords.nil?) ? meta.keywords.to_str : t.meta.keywords
    )
  end

  def make_menu_lists
    @menu_lists = {
      # news_groups: NewsGroup.ordered.all
    }
  end

  # adds language prefix to every url unless locale is native
  def default_url_options
    { locale: r18n.locale.code == APP[:native_locale] || Rails.env.test? ? nil : r18n.locale.code }
  end
end
