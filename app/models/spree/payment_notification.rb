module Spree
  class PaymentNotification < ActiveRecord::Base
    belongs_to :order
    serialize :params

    def self.create_from_params(params)
      email = order.available_payment_methods.last.preferred_email
      token = order.available_payment_methods.last.preferred_token
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
  end
end