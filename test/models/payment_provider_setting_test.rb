require "test_helper"

class PaymentProviderSettingTest < ActiveSupport::TestCase
  test "uses sandbox outside production" do
    setting = PaymentProviderSetting.new(
      provider: "doku",
      app_environment: Rails.env,
      api_key: "api-key",
      client_id: "client-id",
      secret_key: "secret-key",
      enabled: true
    )

    assert_equal "sandbox", setting.doku_environment
    assert setting.save
    assert_equal "secret-key", setting.reload.secret_key
    assert_not_equal "secret-key", setting.attributes_before_type_cast["secret_key"]
  end

  test "requires credentials when enabled" do
    setting = PaymentProviderSetting.new(provider: "doku", app_environment: Rails.env, enabled: true)

    assert_not setting.valid?
    assert_includes setting.errors[:api_key], "can't be blank"
    assert_includes setting.errors[:client_id], "can't be blank"
    assert_includes setting.errors[:secret_key], "can't be blank"
  end

  test "can be disabled without credentials" do
    setting = PaymentProviderSetting.new(provider: "doku", app_environment: Rails.env, enabled: false)

    assert_predicate setting, :valid?
    assert setting.save
  end

  test "finds the DOKU setting for the current application environment" do
    setting = PaymentProviderSetting.for_current_environment

    assert_equal "doku", setting.provider
    assert_equal Rails.env, setting.app_environment
  end
end