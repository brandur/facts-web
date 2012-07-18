module Facts
  module Filters
    class MarkdownFilter
      def initialize
        @tex_map = {}
      end

      def extract(data)
        data
      end

      def process(data)
        renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
          :fenced_code_blocks => true, :hard_wrap => true)
        renderer.render(data)
      end
    end
  end
end
