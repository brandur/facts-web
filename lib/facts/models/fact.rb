module Facts
  module Models
    class Fact
      FILTERS = [
        Filters::LinkFilter.new,
        Filters::MarkdownFilter.new,
        Filters::TexFilter.new,
      ].freeze

      attr_accessor :category, :content, :id

      def initialize(attrs = {})
        self.id       = attrs["id"] || attrs[:id]
        self.category = Category.new(attrs["category"] || attrs[:category] || {})
        self.content  = attrs["content"] || attrs[:content]
      end

      def content_html
        content = self.content
        FILTERS.each { |filter| content = filter.extract(content) }
        FILTERS.each { |filter| content = filter.process(content) }
        content
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
