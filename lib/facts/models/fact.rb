module Facts
  module Models
    class Fact
      attr_accessor :category, :content, :id

      def initialize(attrs = {})
        self.id       = attrs["id"] || attrs[:id]
        self.category = Category.new(attrs["category"] || attrs[:category] || {})
        self.content  = attrs["content"] || attrs[:content]
      end

      def content_html
        renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
          :fenced_code_blocks => true, :hard_wrap => true)
        renderer.render(content)
      end

      def content_html_with_link
        content_html.gsub(/<\/p>\Z/,
          %{ <a href="/#{category.slug}/#{id}">#{id}</a></p>})
      end

      def content_html_with_link_and_category_link
        content_html_with_link.gsub(/\A<p>/,
          %{<p><a href="/#{category.slug}">#{category.name}:</a> })
      end
    end
  end
end
