module Extensions
  module ViewsHelper
    # --------------------------------------------------------------------------
    # pseudo-links/switchers
    # --------------------------------------------------------------------------

    # pseudo-link
    def plink(label, html_data = {}, html_options = { class: 'plink' })
      content_tag :span, label, html_options.merge(data: html_data)
    end

    # pseudo-link with remote attribute
    def plink_to(label, url, html_data = {}, html_options = { class: 'plink', remote: true })
      link_to label, url, html_options.merge(html_data)
    end

    # switching html blocks
    def html_switcher(label, switch_selector, html_options = { class: 'plink' })
      plink label, { switch_selector: switch_selector }, html_options
    end


    # --------------------------------------------------------------------------
    # links
    # --------------------------------------------------------------------------

    # new window/tab link
    def new_window_link_to(label, url, html_options = {})
      html_options[:class] ||= ''
      html_options[:class] << ' new_window'
      link_to label, url, html_options
    end

    # anchor tags
    def anchor_tag(name)
      link_to '', '', name: name
    end


    # --------------------------------------------------------------------------
    # images
    # --------------------------------------------------------------------------

    # image with the same alt and title
    def simple_image(src, title = nil, html_options = {})
      image_tag src, html_options.reverse_merge(alt: title, title: title)
    end


    # --------------------------------------------------------------------------
    # other stuff
    # --------------------------------------------------------------------------

    def list_limits(limits, selected_limit, selected_html_options = {}, tag = :ul, html_options = { class: 'limits' }, &block)
      list = limits.inject([]) do |list, limit|
        s = if limit.to_i == selected_limit.to_i
          content_tag(:span, limit, selected_html_options)
        else
          yield(limit)
        end
        list << (tag == :ul ? content_tag(:li, s) : s)
      end
      content_tag :ul, list.join.html_safe, html_options
    end

  end
end
