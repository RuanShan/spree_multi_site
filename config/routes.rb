Spree::Core::Engine.routes.draw do

  namespace :admin do
    resources :sites
  end
  if Rails.env.development?
    mount Spree::UserMailer::Preview => 'mail_view'
  end
end

#map.namespace :admin do |admin|
#  admin.resources :sites
  ## admin.resources :taxonomies, :has_many => [:variants, :images, :product_properties] do |product|
#end  
