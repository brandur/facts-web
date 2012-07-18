module Facts
  module Models
    class Category
      attr_accessor :facts, :name, :slug

      def initialize(attrs = {})
        self.name  = attrs["name"] || attrs[:name]
        self.slug  = attrs["slug"] || attrs[:slug]
        self.facts = (attrs["facts"] || attrs[:facts] || []).
          map { |f| Fact.new(f) }
      end
    end
  end
end
