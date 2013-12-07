module Spree
  class PaymentNotification < ActiveRecord::Base
    belongs_to :order
    serialize :params

    def self.create_from_params(params)
      payment_method = pagseguro_payment_method
      email = payment_method.preferred_email
      token = payment_method.preferred_token
      notification_code = params[:notificationCode]
      notification = ::PagSeguro::Notification.new(email, token, notification_code)

      self.create!(
        params: params,
        order_id: notification.id,
        status: notification.status,
        transaction_id: notification.transaction_id,
        notification_code: notification_code
      )
      
      notification
    end

    private

    def pagseguro_payment_method
      Spree::PaymentMethod.find_by type: "Spree::PaymentMethod::Pagseguro"
    end
  end
end