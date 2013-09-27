require_relative '../report-generator.rb'
require_relative 'file_util.rb'

describe ReportGenerator do

	before(:each) do
		@file_util = FileUtil.new
		tmp_repo_path = @file_util.setup_tmp_repo_dir
		@report_generator = ReportGenerator.new File.join(tmp_repo_path, 'test-repos')
	end

	after(:each) do
		@file_util.remove_tmp_repo_dir
	end

	context "when calling get_repos" do
		before(:each) do
			@repos = @report_generator.get_repos
		end

		it "should return test-repo 1 and 2" do
			expect(@repos[0]).to eq('test-repo-1') # Should use another matcher, such as 'to contain' (same with branch_names below)
			expect(@repos[1]).to eq('test-repo-2') # Does the order matter?
		end

		it "should return exactly 2 repos" do
			expect(@repos.count).to eq(2)
		end
	end

	context "when calling get_branch_names" do
		before(:each) do
			@branch_names = @report_generator.get_branch_names
		end

		it "should return correct number of branch names (all of them)" do
			expect(@branch_names.count).to eq(7)
		end

		it "should return develop branch of test-repo-1" do
			expect(@branch_names[0]).to eq('test-repo-1 develop')
		end

		it "should return second release branch of test-repo-2" do
			expect(@branch_names[6]).to eq('test-repo-2 release/second-release')
		end
	end
end