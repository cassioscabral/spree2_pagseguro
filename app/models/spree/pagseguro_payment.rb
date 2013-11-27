module Spree
  class PagseguroPayment < ActiveRecord::Base
    attr_accessor :order_id
    belongs_to :payment
    
    def process!(payment)
      order = payment.order
      
      redirect_url = Rails.env.development? ? nil : "#{Spree::Config.site_url}/pag_seguro/callback"

      pagseguro_payment = ::PagSeguro::Payment.new(
        Order.pagseguro_payment_method.preferred_email,
        Order.pagseguro_payment_method.preferred_token,
        redirect_url: redirect_url,
        extra_amount: format("%.2f", (order.total - order.item_total).round(2)),
        id: order.id)

      pagseguro_payment.items = order.line_items.map do |item|
        pagseguro_item = ::PagSeguro::Item.new
        pagseguro_item.id = item.id
        pagseguro_item.description = item.product.name
        pagseguro_item.amount = format("%.2f", item.price.round(2))
        pagseguro_item.quantity = item.quantity
        pagseguro_item.weight = (item.product.weight * 1000).to_i if item.product.weight.present?
        pagseguro_item
      end

      pagseguro_payment.sender = ::PagSeguro::Sender.new(name: order.name, email: order.email, phone_number: order.ship_address.phone)
      pagseguro_payment.shipping = ::PagSeguro::Shipping.new(type: ::PagSeguro::Shipping::SEDEX, state: (order.ship_address.state ? order.ship_address.state.abbr : nil), city: order.ship_address.city, postal_code: order.ship_address.zipcode, street: order.ship_address.address1, complement: order.ship_address.address2)
      self.code = pagseguro_payment.code
      self.date = pagseguro_payment.date
      self.payment = payment
      self.save
    end
  end
end
