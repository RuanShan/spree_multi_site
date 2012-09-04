class Spree::Site < ActiveRecord::Base
  cattr_accessor :current
  has_many :taxonomies,:inverse_of =>:site,:dependent=>:destroy
  has_many :products,:inverse_of =>:site,:dependent=>:destroy
  has_many :orders,:inverse_of =>:site,:dependent=>:destroy
  has_many :users,:inverse_of =>:site,:dependent=>:destroy
  has_many :tax_categories,:inverse_of =>:site,:dependent=>:destroy
  
  has_many :shipping_categories,:dependent=>:destroy
  has_many :prototypes,:dependent=>:destroy
  has_many :option_types,:dependent=>:destroy
  has_many :properties,:dependent=>:destroy
  has_many :payment_methods,:dependent=>:destroy
  has_many :assets,:dependent=>:destroy
  
  has_many :taxons, :through => :taxonomies
  validates_presence_of   :name, :domain
  acts_as_nested_set
  accepts_nested_attributes_for :users
  
  self.current = Struct.new(:id)[]
  # it is load before create site table. self.new would trigger error "Table spree_sites' doesn't exist"
  # db/migrate/some_migration is using Spree::Product, it has default_scope using Site.current.id
  # so it require a default value.
  
  def load_sample(be_loading = true)
    # global talbes
    #   countries,states, zones, zone_members, roles #admin
    # activators,
    # tables belongs to site
    #   addresses -> user(site)
    #   configuration(site)
    #   log_entries(site)
    #   orders(site)->[state_changes,inventory_units,tokenized_permission]
    #   [properties(site), prototypes(site)] -> properties_prototypes
    #                    , option_types(site)] ->option_type_prototypes
    #         ->products(site)->variants(site?)->assets(site)
    #   payment_methods(site)->payments->adjustments 
    #   preference(site)
    #   tax_categories(site)-> tax_rates -> [shipping_methods, promotions,calculators]
    #   taxonomies(site) -> taxons(site) -> products_taxons(site?)
    #   user
    # to be confirm
    #   spree_tracker, state_changes
    #   return_authorizations
    #   mail_methods, pending_promotions, product_promotion_*
    # unused table
    #   credit_cars(site?), gateways(site?)
    #
    original_current_website, self.class.current = self.class.current, self 
    
    if be_loading!=true #
      self.orders.each{|order|
        order.state_changes.clear
        order.inventory_units.clear
        order.tokenized_permission.delete
        order.destroy
      }
      self.products.clear
      self.properties.clear
      self.payment_methods.each{|pm| pm.delete}
      self.prototypes.clear
      self.option_types.clear
      self.shipping_categories.clear
      self.tax_categories.clear
      self.taxonomies.each{|taxonomy|
        taxonomy.taxons.clear
        taxonomy.destroy
      }
      #TODO fix taxons.taconomy_id
      self.users.find(:all,:include=>[:ship_address,:bill_address],:offset=>1, :order=>'id').each{|user|
        user.bill_address.destroy
        user.ship_address.destroy
        user.destroy
        } #skip first admin
      #shipping_method, calculator, creditcard, inventory_units, state_change,tokenized_permission
      #TODO remove image files
      self.assets.clear
      return
    end
    
    require 'ffaker'
    require 'erb'
    require 'spree_multi_site/custom_fixtures'
    # only load sample from one folder. by default is 'Rails.application.root/db/sample'
    # could override it by setting Spree::Config.data_path
      dir = File.join(SpreeMultiSite::Config.data_path,'sample')
  Rails.logger.debug "load sample from dir=#{dir}"
      fixtures = ActiveSupport::OrderedHash.new
      ruby_files = ActiveSupport::OrderedHash.new
      Dir.glob(File.join(dir , '**/*.{yml,csv,rb}')).each do |fixture_file|
        ext = File.extname fixture_file
        if ext == ".rb"
          ruby_files[File.basename(fixture_file, '.*')] = fixture_file
        else
          fixtures[fixture_file.sub(dir, "")[1..-1]] = fixture_file
        end
      end
      # put eager loading model ahead, 
      order_indexes = ['sites',
        'shipping_categories','payment_methods',
        'properties','option_types','option_values', 
        'tax_categories','tax_rates','shipping_methods','promotions','calculators',
        'products','product_properties','product_option_types','variants','assets', 
        'taxonomies','taxons',
        'addresses','users','orders','line_items','shipments','adjustments']
      #{:a=>1, :b=>2, :c=>3}.sort => [[:a, 1], [:b, 2], [:c, 3]] 
      sorted_fixtures = fixtures.sort{|a,b|
        key1,key2  = a.first.sub(".yml", "").sub("spree/", ""), b.first.sub(".yml", "").sub("spree/", "")  #a.first is relative_path
  #puts "a=#{a.inspect},b=#{b.inspect} \n key1=#{key1}, key2=#{key2}, #{(order_indexes.index(key1)<=> order_indexes.index(key2)).to_i}"      
        i = (order_indexes.index(key1)<=> order_indexes.index(key2)).to_i
        i==0 ? -1 : i # key not in order_indexes should be placed ahead.
      }
      sorted_fixtures.each do |relative_path , fixture_file|
        # load fixtures  
        # load_yml(dir,fixture_file)
  Rails.logger.debug "loading fixture_file=#{fixture_file}"
        SpreeMultiSite::Fixtures.create_fixtures(dir, relative_path.sub(".yml", ""))
      end
  #puts "create habtm records"      
      SpreeMultiSite::Fixtures.create_habtm_records    
      ruby_files.sort.each do |fixture , ruby_file|
        # an invoke will only execute the task once
  Rails.logger.debug  "loading ruby #{ruby_file}"
        require ruby_file
      end
      SpreeMultiSite::Fixtures.reset_cache
        
    self.class.current = original_current_website
  end
  
  #set default_scope before call this method
  #call rake task to load sample instead of this method.
  #self.delay(:queue=>"load_sample").load_sample
  
end
