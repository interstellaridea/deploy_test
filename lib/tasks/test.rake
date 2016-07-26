

namespace :zoom do

	desc "This is a test db creator"
	task :add_user => :environment do

		user = User.new(:email => 'svaldez@solarcity.com')

		#user.save

		print "#{user} has been saved to database"
	end
end