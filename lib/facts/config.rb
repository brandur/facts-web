module Facts
  module Config
    extend self

    def api
      @api ||= env!("HTTP_API")
    end

    def force_ssl?
      @force_ssl ||= %w{1 true}.include?(env("FORCE_SSL"))
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
