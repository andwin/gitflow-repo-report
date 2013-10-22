ENV['RACK_ENV'] = 'test'

require_relative '../gitflow_repo_report.rb'
require 'rspec'
require 'rack/test'

describe 'The gitflow repo report App' do
	include Rack::Test::Methods

	def app
		ENV['TEST_REPO_PATH'] = 'test'

		Sinatra::Application
	end

	it "loads ok" do
		get '/'
		expect(last_response).to be_ok
		expect(last_response.body).to include('GitFlow report')
	end
end