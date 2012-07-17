module Facts
  module Config
    extend self

    def api
      @api ||= env!("HTTP_API")
    end

    private

    def env(k)
      ENV[k] unless ENV[k].nil?
    end

    def env!(k)
      env(k) || raise("missing_environment=#{k}")
    end
  end
end
