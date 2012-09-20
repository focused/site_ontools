module Extensions
  module ViewsHelper
    # ==========================================================================
    # pseudo-links/switchers
    # ==========================================================================

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


    # ==========================================================================
    # links
    # ==========================================================================

    # new window/tab link
    def new_window_link_to(label, url, html_options = {})
      html_options[:class] ||= ''
      html_options[:class] << ' new_window'
      link_to label, url, html_options
    end


    # ==========================================================================
    # images
    # ==========================================================================

    # image with the same alt and title
    def simple_image(src, title = nil, html_options = {})
      image_tag src, html_options.reverse_merge(alt: title, title: title)
    end
  end
end
