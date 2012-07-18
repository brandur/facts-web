require "test_helper"

module Facts
  module Models
    describe Fact do
      it "initializes" do
        fact = Fact.new(id: 1, content: "The world is **big**.",
          category: { name: "World", slug: "world" })
        fact.id.must_equal 1
        fact.content.must_equal "The world is **big**."
        fact.category.name.must_equal "World"
        fact.category.slug.must_equal "world"
      end

      it "renders content as markdown" do
        fact = Fact.new(content: "The world is **big**.")
        fact.content_html.must_match %r{The world is <strong>big</strong>.}
      end
    end
  end
end
