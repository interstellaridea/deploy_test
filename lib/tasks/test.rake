# Creates
def zoomAPI( endpoint, params = {} )
  # Environment Vars
  apiKey = ENV['Zoom_API_Key']
  apiSecret = ENV['Zoom_API_Secret']
  baseUri = "https://api.zoom.us/"
  dataType = "data_type=JSON"
  version = 'v1/'
  results = Array.new

  # Adds Key, Secret and DataType to passed Array
  results = [
    "api_key=#{apiKey}",
    "api_secret=#{apiSecret}",
    "#{dataType}"
  ]
  # ADD go through hash and push key and values to results array
  params.each do |key, value|
    results.push("#{key}=#{value}")
  end

  # Create and reurn one Url for HTTPARY to use
  url = "#{baseUri}" + "#{version}" +  "#{endpoint}" + "?" +  results.join('&')
  return url
end
### ### ###

### Add capitalize? methods to string class ###
class String
  def capitalized?
    chars.first == chars.first.upcase
  end
end
### ### ###
## Check for valid string DateTime, flip to datetime
def valid_time(time)
  time.empty? ? time = "N/A" : time = DateTime.parse(time)
end
### #### ###

namespace :zoom do

  desc "Get Zoom User ID using email"
  task :id_by_email, [:email] => :environment do |item ,args|
    # Create API request
    url = zoomAPI( 'user/getbyemail', :login_type=>101, :email=>"#{args.email}" )
    # POST request to Zoom base API URL
    response = HTTParty.post(url)

    # Save ID
    id = response['id']

    print "Code response was #{response.code} \n"

    print " USER ID is : #{id} \n"
  end


	desc "This is a test db creator"
	task :add_user => :environment do

		user = User.new(:email => 'svaldez@solarcity.com')

		user.save

		print "#{user} has been saved to database"
	end
end