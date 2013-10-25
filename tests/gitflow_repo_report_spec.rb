ENV['RACK_ENV'] = 'test'

require_relative '../gitflow_repo_report.rb'
require 'rspec'
require 'capybara/rspec'

describe 'The Gitflow Repo Report App', :type => :feature do

	before(:all) do
		@file_util = FileUtil.new
		@file_util.setup_tmp_dir
		@report_generator = ReportGenerator.new @file_util.tmp_repos_path
	end

	after(:all) do
		@file_util.cleanup_tmp_dir
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