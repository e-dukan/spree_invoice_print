module SpreeInvoicePrint
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_invoice_print'

    config.autoload_paths += %W(#{config.root}/lib)


     #Added initializer for company information preferences
    initializer "spree.spree_invoice_print.preferences", :after => "spree.environment" do |app|
      Spree::CompanyConfig = Spree::CompanyConfiguration.new
      Spree::InvoicePrintConfig = Spree::InvoicePrintConfiguration.new
    end


    initializer "spree.spree_invoice_print.mimetypes" do |app|
      Mime::Type.register('application/pdf', :pdf) unless Mime::Type.lookup_by_extension(:pdf)
    end


    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
