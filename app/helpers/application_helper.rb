require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

module ApplicationHelper

class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet # yep, that's it.

end

  def markdown(text)
    options = {
      filter_html:     false,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      no_intra_emphasis:   true
     }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true,
      footnotes:          true,
      fenced_code_blocks: true,
      highlight:          true
    }

    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    # find_and_preserve is a HAML helper that will fix
    # unnecessary indentation in codeblocks.
    find_and_preserve(markdown.render(text)).html_safe
  end


  def getfilename(url)
    output = File.basename(url)
  end
end
