Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # replace this with the domain of your React app
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options], redirect: false
  end
end