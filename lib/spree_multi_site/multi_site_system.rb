# Spree::BaseController.class_eval would not work
# Spree::UserSessionsController derive from Devise::SessionsController, it included Spree::Core::ControllerHelpers
require 'spree/core/controller_helpers'
class<< Spree::Core::ControllerHelpers
  def included_with_site_support(receiver)
    receiver.send :include, Spree::MultiSiteSystem
    receiver.send :helper_method, 'current_site'
    receiver.send :helper_method, 'current_site='
    receiver.send :helper_method, 'get_site_and_products'
    #puts "do something befor original included"
    included_without_site_support(receiver)
    receiver.before_filter :get_site_and_products
  end
  alias_method_chain :included, :site_support 
end

module Spree
  module MultiSiteSystem
    def current_site
      @current_site ||= (get_site_from_request  || Spree::Site.first)
    end
    
    def current_site=(new_site)
      #TODO raise error new_site.nil?
      session[:site_id] = new_site.nil? ? nil : new_site.id
      @current_site = new_site 
    end
    
    def get_site_from_request      
      a_site = Spree::Site.find_by_domain(request.host)
      if Rails.env !~ /prduction/ && a_site.blank?  
        # for development or test, enable get site from cookies
        if cookies[:abc_development_domain].present?
          a_site = Spree::Site.find_by_domain( cookies[:abc_development_domain] )
        end        
      end
      a_site
    end
    
    def get_site_and_products
      Spree::Site.current = current_site
      logger.debug "current_site=#{current_site}"
      #raise ArgumentError  if @site.nil?
      #logger.debug "product.all=#{Spree::Product.all}"
      @taxonomies = (current_site ? current_site.taxonomies : [])
    end
    
    #override original methods 
    def get_layout
      current_site.layout.present? ? current_site.layout : Spree::Config[:layout]
    end
  
    def find_order      
      unless session[:order_id].blank?
        @order = Order.find_or_create_by_id(session[:order_id])
      else      
        @order = Order.create
      end
      @order.site = current_site
      session[:order_id] = @order.id
      @order
    end
  
  end
end