Spree::Image.class_eval do
#override attachement[:path]      
  Spree::Image.attachment_definitions[:attachment][:url] = '/shops/:site/products/:id/:basename_:style.:extension'

  Spree::Image.attachment_definitions[:attachment][:path] = ':rails_root/public/shops/:site/products/:id/:basename_:style.:extension'

end