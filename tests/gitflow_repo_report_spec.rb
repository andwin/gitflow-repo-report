ENV['RACK_ENV'] = 'test'

require_relative '../gitflow_repo_report.rb'
require 'rspec'
require 'rack/test'

describe 'The gitflow repo report App' do
	include Rack::Test::Methods

	before(:all) do
		@file_util = FileUtil.new
		@file_util.setup_tmp_dir
		@report_generator = ReportGenerator.new @file_util.tmp_repos_path
	end

	after(:all) do
		@file_util.remove_tmp_dir
	end

	def app
		Sinatra::Application
	end

	context 'when starting from the begining' do
		it 'loads ok' do
			get '/'
			expect(last_response).to be_ok
		end

		it 'has no report on index' do
			get '/'
			expect(last_response.body).to include('No reports found!')
		end
	end
end