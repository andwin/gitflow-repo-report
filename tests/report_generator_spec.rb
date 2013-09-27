require_relative '../report-generator.rb'
require_relative 'file_util.rb'

describe ReportGenerator do

	before(:each) do
		@file_util = FileUtil.new
		tmp_repo_path = @file_util.setup_tmp_repo_dir
		@report_generator = ReportGenerator.new tmp_repo_path
	end

	after(:each) do
		@file_util.remove_tmp_repo_dir
	end

	context "result of call to get_repos" do
		before(:each) do
			@repos = @report_generator.get_repos
		end

		it "should include test-repo 1 and 2" do
			expect(@repos).to include('test-repo-1')
			expect(@repos).to include('test-repo-2')
		end

		it "should contain exactly 2 repos" do
			expect(@repos.count).to eq(2)
		end
	end

	context "result of call to get_branch_names" do
		before(:each) do
			@branch_names = @report_generator.get_branch_names
		end

		it "should contain correct number of branch names (all of them)" do
			expect(@branch_names.count).to eq(7)
		end

		it "should include develop branch of test-repo-1" do
			expect(@branch_names).to include('test-repo-1 develop')
		end

		it "should include second release branch of test-repo-2" do
			expect(@branch_names).to include('test-repo-2 release/second-release')
		end
	end
end