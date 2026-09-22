module Payments
  module Providers
    module Doku
      module Credentials
        module_function

        def call
          setting = PaymentProviderSetting.for_current_environment
          return setting.credentials if setting.persisted? && setting.enabled?

          {
            api_key: ENV.fetch("DOKU_API_KEY"),
            client_id: ENV.fetch("DOKU_CLIENT_ID"),
            secret_key: ENV.fetch("DOKU_SECRET_KEY"),
            environment: Rails.env.production? ? "production" : "sandbox"
          }
        end
      end
    end
  end
end