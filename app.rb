#
# Copyright IBM Corp. 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'sinatra'
require 'json'
require 'excon'
require 'cgi'

configure do
  service_name = "message_resonance"

  endpoint = Hash.new

  set :endpoint, "<service_url>"
  set :username, "<service_username>"
  set :password, "<service_password>"

  if ENV.key?("VCAP_SERVICES")
    services = JSON.parse(ENV["VCAP_SERVICES"])
    if !services[service_name].nil?
      credentials = services[service_name].first["credentials"]
      set :endpoint, credentials["url"]
      set :username, credentials["username"]
      set :password, credentials["password"]
    else
      puts "The service #{service_name} is not in the VCAP_SERVICES, did you forget to bind it?"
    end
  end

  puts "endpoint = #{settings.endpoint}"
  puts "username = #{settings.username}"
end

get '/' do
  @tokens = []
  erb :index
end

post '/' do
  @message = params[:message]
  @dataset = params[:dataset]

  @tokens = []

  begin
    unless @message.nil?
      # for each word in message
      @message.split().each do |p|
        @tokens.push(getScoreForWord(p, @dataset))
      end
    end
  rescue Exception => e
    @error = 'Error processing the request, please try again later.'
    puts  e.message
    puts  e.backtrace.join("\n")
    return erb :index
  end

   erb :index
end

def ring_scale(score)
      case score
        when 0..10
          return "low"
        when 11..20
          return "med"
        when 21..30
          return "high"
        when 31..40
          return "hot"
        when 41..100
          return "extreme"
      end
end

helpers do

  # Create a job
  def getScoreForWord(word,dataset)
    eword = CGI.escape(word)
    response = Excon.get(settings.endpoint + "/ringscore?dataset=#{@dataset}&text=#{eword}",
     :headers => { "Content-Type" => "application/json" },
     :user => settings.username,
     :password => settings.password)

    JSON.load(response.body)
  end

end