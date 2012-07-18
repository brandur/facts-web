module Facts
  class ExconInstrumentor
    attr_accessor :events

    def initialize(id = nil)
      @id = id
    end

    def instrument(name, params = {}, &block)
      Slides.log name, host: params[:host], path: params[:path],
        method: params[:method], expects: params[:expects], id: @id do
          yield if block_given?
      end
    end
  end
end
