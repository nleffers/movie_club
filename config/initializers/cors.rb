# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

if Rails.env.development?
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'

      resource '*',
               headers: :any,
               methods: %i[get post delete options put]
    end
  end
else
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://immense-mountain-08471.herokuapp.com'

      resource '*',
               headers: :any,
               methods: %i[get post delete options put]
    end
  end

  module Rack
    class Cors
      # resource class
      class Resource
        # Gross duck-punching to get this working in environments where we don't manage CORS directly
        def to_headers(env)
          h = {
            'Access-Control-Allow-Origin' => origin_for_response_header(env[Rack::Cors::HTTP_ORIGIN]),
            'Access-Control-Allow-Methods' => methods.collect { |m| m.to_s.upcase }.join(', '),
            'Access-Control-Allow-Headers' => headers.collect { |h| h.to_s }.join(',')
          }
          h['Access-Control-Allow-Credentials'] = true if credentials
          h
        end
      end
    end
  end
end
