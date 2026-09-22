module Admin
  class PaymentGatewayController < BaseController
    before_action :require_admin_user

    def show
      @setting = PaymentProviderSetting.for_current_environment
    end

    def update
      @setting = PaymentProviderSetting.for_current_environment
      @setting.assign_attributes(payment_gateway_params)

      if @setting.save
        redirect_to admin_payment_gateway_path, notice: "Payment gateway settings saved."
      else
        render :show, status: :unprocessable_content
      end
    end

    private

    def require_admin_user
      return if current_user&.admin?

      redirect_to admin_root_path, alert: "Only administrators can manage payment gateway settings."
    end

    def payment_gateway_params
      permitted = params.require(:payment_provider_setting).permit(:api_key, :client_id, :secret_key, :enabled)
      permitted.to_h.reject { |key, value| %w[api_key client_id secret_key].include?(key) && value.blank? }
    end
  end
end