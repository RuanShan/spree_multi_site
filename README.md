SpreeMultiSite
==============

Introduction goes here.

url for site admin 
http://localhost:3000/admin/sites

Example
=======

Example goes here.

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test app
    $ bundle exec rspec spec

    # if you delete all migrations in db/migrate, try all belows to recovery
    rake spree:install:migrations                          # copy migrations from spree_core
    rake spree_api:install:migrations                      # Copy migrations from spree_api to application
    rake spree_auth:install:migrations                     # Copy migrations from spree_auth to application
    rake spree_promo:install:migrations      
    rake spree_multi_site:install:migrations               # Copy migrations from spree_multi_site to applica...
    # load default data, no sample
    $ bundle rake db:reset 
Copyright (c) 2012 [name of extension creator], released under the New BSD License
