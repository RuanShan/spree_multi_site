#source 'http://ruby.taobao.org'
source 'http://rubygems.org'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '2-0-stable'


gem 'daemons' #require it while running script/delayed_job.
gem 'delayed_job_active_record'

group :development,:test do
  gem 'mail_view', :git => 'https://github.com/37signals/mail_view.git'
end

gemspec

#start server for test
#rails s -p3002 -etest
