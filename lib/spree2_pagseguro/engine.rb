module Spree2Pagseguro
  require 'spree/core'
  engine_name 'spree2_pagseguro'

  config.autoload_paths += %W(#{config.root}/lib)

  # use rspec for tests
  config.generators do |g|
    g.test_framework :rspec
  end

  initializer "spree.register.pagseguro_payment_method", after: "spree.register.payment_methods" do |app|
    app.config.spree.payment_methods << Spree::PaymentMethod::Pagseguro
  end

  def self.activate
    Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
      Rails.configuration.cache_classes ? require(c) : load(c)
    end
  end

  config.to_prepare &method(:activate).to_proc
end