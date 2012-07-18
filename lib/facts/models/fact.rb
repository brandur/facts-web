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
    end
  end
end
