class PagesController < ApplicationController
  respond_to :html

  load_and_authorize_resource

  def show
    params[:path] ||= "/"

    @page = Page.by_path(params[:path])
    if @page.present?
      meta = PageMetaTag.by_path(params[:path].to_s)
      set_meta_tags(
        title: (meta.try(:title).present? and !meta.title.nil?) ? meta.title.to_str : t.meta.title,
        description: (meta.try(:description).present? and !meta.description.nil?) ? meta.description.to_str : t.meta.description,
        keywords: (meta.try(:keywords).present? and !meta.keywords.nil?) ? meta.keywords.to_str : t.meta.keywords
      )
    elsif params[:path] == "simulate_exception"
      render file: "/simulate_exception"
    else
      not_found
    end
  end

end
