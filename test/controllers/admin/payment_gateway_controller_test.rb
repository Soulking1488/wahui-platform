require "test_helper"

class Admin::PaymentGatewayControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "admin can view and save DOKU settings" do
    admin = User.create!(email: "gateway-admin@example.com", password: "Password123!", role: "admin")
    sign_in admin

    get admin_payment_gateway_path

    assert_response :success
    assert_includes response.body, "Payment gateway"
    assert_includes response.body, "sandbox"

    patch admin_payment_gateway_path, params: {
      payment_provider_setting: {
        api_key: "doku-api-key",
        client_id: "doku-client-id",
        secret_key: "doku-secret-key",
        enabled: "1"
      }
    }

    assert_redirected_to admin_payment_gateway_path
    setting = PaymentProviderSetting.for_current_environment
    assert setting.enabled?
    assert_equal "doku-secret-key", setting.secret_key
  end

  test "house operators cannot manage payment gateway settings" do
    operator = User.create!(email: "gateway-operator@example.com", password: "Password123!", role: "house_operator")
    sign_in operator

    get admin_payment_gateway_path

    assert_redirected_to admin_root_path
    assert_equal 0, PaymentProviderSetting.count
  end
end