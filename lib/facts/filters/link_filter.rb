module Facts
  module Filters
    # processes internal links; external links are left for Markdown
    class LinkFilter
      def initialize
        @link_map = {}
      end

      def extract(data)
        data.gsub(/\[(.+)\]\(([a-z-]+)\)/) do
          text, category = $1, $2
          id = Digest::SHA1.hexdigest("#{text}|#{category}")
          @link_map[id] = [text, category]
          id
        end
      end

      def process(data)
        @link_map.each do |id, spec|
          text, category = *spec
          out = %{<a href="/#{category}">#{text}</a>}
          data.gsub!(id, out)
        end
        data
      end
    end
  end
end
