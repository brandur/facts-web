require_relative "../test_helper"

module Facts
  module Models
    describe Category do
      it "initializes" do
        category = Category.new(name: "World", slug: "world",
          facts: [ { content: "The world is **big**." } ])
        category.name.must_equal "World"
        category.slug.must_equal "world"
        category.facts.first.category.must_equal category
        category.facts.first.content.must_equal "The world is **big**."
      end
    end
  end
end
