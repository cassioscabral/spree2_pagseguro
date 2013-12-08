module PagseguroHelper
  def pedido
    order = current_order
      
      redirect_url = Rails.env.development? ? nil : "#{Spree::Config.site_url}/pag_seguro/callback"
      payment_method = Spree::PaymentMethod.find_by type: "Spree::PaymentMethod::Pagseguro"
      pag_seguro_payment = ::PagSeguro::Payment.new(
        order.payment_method.preferred_email,
        order.payment_method.preferred_token,
        redirect_url: redirect_url,
        extra_amount: format("%.2f", (order.total - order.item_total).round(2)),
        id: order.id)

      pag_seguro_payment.items = order.line_items.map do |item|
        pag_seguro_item = ::PagSeguro::Item.new
        pag_seguro_item.id = item.id
        pag_seguro_item.description = item.product.name
        pag_seguro_item.amount = format("%.2f", item.price.round(2))
        pag_seguro_item.quantity = item.quantity
        pag_seguro_item.weight = (item.product.weight * 1000).to_i if item.product.weight.present?
        pag_seguro_item
      end

      #pag_seguro_payment.sender = ::PagSeguro::Sender.new(name: order.name, email: order.email, phone_number: order.ship_address.phone)
      #pag_seguro_payment.shipping = ::PagSeguro::Shipping.new(type: ::PagSeguro::Shipping::SEDEX, state: (order.ship_address.state ? order.ship_address.state.abbr : nil), city: order.ship_address.city, postal_code: order.ship_address.zipcode, street: order.ship_address.address1, complement: order.ship_address.address2)
      pagamento = {}
      pagamento[:code] = pag_seguro_payment.code
      pagamento[:date] = pag_seguro_payment.date
      pagamento
  end
end
