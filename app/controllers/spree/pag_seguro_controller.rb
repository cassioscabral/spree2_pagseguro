module Spree
  class PagSeguroController < BaseController
    include Spree::Core::ControllerHelpers::Order
    protect_from_forgery :except => [:notify]
    skip_before_filter :restriction_access

    def notify
      notification = Spree::PaymentNotification.create_from_params(params)

		  #https://github.com/heavenstudio/pag_seguro/blob/master/lib/pag_seguro/transaction.rb
			# possible status values          # Método do spree para passar o pagamento para o tal estado. O payments.last só funciona no caso de um único pagamento e o único meio de pagamento é o pagseguro. Para ser genérico precisa ver todos os pagamentos e saber qual deles é o do PagSeguro.
      # PAGSEGURO_PROCESSING        = 1 order.payments.last.started_processing # passa para o estado de processando
      # PAGSEGURO_IN_ANALYSIS       = 2
      # PAGSEGURO_APPROVED          = 3 order.payments.last.complete
      # PAGSEGURO_AVAILABLE         = 4
      # PAGSEGURO_DISPUTED          = 5
      # PAGSEGURO_RETURNED          = 6
      # PAGSEGURO_CANCELLED         = 7 order.payments.last.failure
		  #
      # # possible type values
      # PAGSEGURO_PAYMENT           = 1
      # PAGSEGURO_TRANSFER          = 2
      # PAGSEGURO_ADDITION_OF_FUNDS = 3
      # PAGSEGURO_CHARGE            = 4
      # PAGSEGURO_BONUS             = 5
      
      @order = Spree::Order.find(notification.order_id)
      case notification.status
      when "1" # processando o pagamento
        Order.transaction do
          @order.payments.last.started_processing
        end
      when "3" # pagamento aprovado
        Order.transaction do
          @order.payments.last.complete
        end
      when "7" # pagamento cancelado
        Order.transaction do
          @order.payments.last.failure
        end
      else
        logger.warn "O pagamento teve esta notificacao e caiu no caso generico"
        logger.warn "#{notification}"
      end

      render nothing: true, head: :ok
    end

    def callback
    end

  end
end
