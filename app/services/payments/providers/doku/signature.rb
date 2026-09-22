require "base64"
require "digest"
require "openssl"

module Payments
  module Providers
    module Doku
      module Signature
        module_function

        def digest(body)
          Base64.strict_encode64(Digest::SHA256.digest(body.to_s))
        end

        def generate(client_id:, timestamp:, path:, body:, secret_key:)
          request_digest = digest(body)
          component = [client_id, timestamp, path, request_digest].join("\n")
          encoded = OpenSSL::HMAC.digest("SHA256", secret_key, component)

          "HMACSHA256=#{Base64.strict_encode64(encoded)}"
        end

        def secure_compare(left, right)
          return false unless left && right && left.bytesize == right.bytesize

          OpenSSL.fixed_length_secure_compare(left, right)
        end
      end
    end
  end
end