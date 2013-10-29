ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'capybara/rspec'
require_relative 'test_utils.rb'
require_relative '../gitflow_repo_report.rb'

describe 'The Gitflow Repo Report App', :type => :feature do

	before(:all) do
		@test_utils = TestUtils.new
		@test_utils.setup_tmp_dir
		@report_generator = ReportGenerator.new @test_utils.tmp_repos_path
	end

	after(:all) do
		@test_utils.cleanup_tmp_dir
	end

	Capybara.app = Sinatra::Application

	context 'when starting from the begining' do
		it 'loads ok' do
			visit '/'
			expect(page.status_code).to be 200
		end

		it 'has no report on index' do
			visit '/'
			expect(page).to have_content 'No reports found!'
		end

		it 'has no reports in list' do
			visit '/list/'
			expect(page).to have_selector('.report-list li', count: 0)
		end

		it 'generates report when asked to do so' do
			visit '/generate/'
			expect(page).to have_content 'The report is generated!'

			visit '/'
			expect(page).to have_no_content 'No reports found!'

			visit '/list/'
			expect(page).to have_selector('.report-list li', count: 1)
		end

	end
end