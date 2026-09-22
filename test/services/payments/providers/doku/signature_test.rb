require "test_helper"

class Payments::Providers::Doku::SignatureTest < ActiveSupport::TestCase
  test "generates the DOKU global signature from the exact request components" do
    body = '{"order":{"amount":100.25}}'

    digest = Payments::Providers::Doku::Signature.digest(body)
    signature = Payments::Providers::Doku::Signature.generate(
      client_id: "BRN-001-0000001",
      timestamp: "2026-09-22T00:00:00Z",
      path: "/v3/checkouts",
      body:,
      secret_key: "secret-key"
    )

    assert_equal "LO4aJWkGwYXn4jfZ0127Lup3VEjDIZrmZm2r6gTByiA=", digest
    assert_equal "HMACSHA256=3k0oz3P1cS41XLQpzSVIjwifvNJ+NqKRTx/JuewULgw=", signature
  end
end