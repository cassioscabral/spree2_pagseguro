module Spree
  class PaymentMethod::Pagseguro < PaymentMethod
    preference :email, :string
    preference :token, :string


    #adicionar atributos as listas de permitidos
    #attr_accessible :preferred_moip_token, :preferred_moip_key, :preferred_currency, :preferred_moip_environment
    
    def provider_class
      Spree::PagseguroPayment
    end

    def payment_source_class
      nil
    end

    def actions
      %w{capture void}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      ['checkout', 'pending'].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def void(*args)
      ActiveMerchant::Billing::Response.new(true, "", {}, {})
    end

    def source_required?
      false
    end


    # metodos do spree_pag_seguro, ainda n sei a utilidade

    # attr_protected
    # attr_accessor :order_id
    # has_many :payments, :as => :source
    
    # def payment_source_class
    #   self.class
    # end

    # def code(payment)
    #   if payment.pag_seguro_payment.present?
    #     payment.pag_seguro_payment.code
    #   else
    #     pag_seguro_payment = Spree::PagSeguroPayment.new
    #     pag_seguro_payment.process!(payment)
    #     pag_seguro_payment.code
    #   end
    # end
  end
end