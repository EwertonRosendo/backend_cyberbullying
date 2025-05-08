Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # ✅ allows requests from any origin
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        expose: ['Content-Disposition'] # Optional: expose headers if needed
    end
  end