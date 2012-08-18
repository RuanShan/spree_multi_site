class SampleSeedJob < Struct.new(:site)
  def perform
    Spree::Site.current = site 
    #site.users.first, it require `spree_users`.`site_id` =current_site.id
    admin_user = site.users.first
    site.load_sample
Rails.logger.debug "site=#{site.inspect}"    
Rails.logger.debug "user=#{admin_user.inspect}"
    Spree::UserMailer.load_sample(admin_user).deliver
  end

  def success(job)
    site.update_attributes!(:loading_sample=>false)
  end
end