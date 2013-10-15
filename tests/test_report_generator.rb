require 'test/unit'
require_relative '../report_generator.rb'
require_relative 'file_util.rb'

class TestReportGenerator < Test::Unit::TestCase
	def setup
		@file_util = FileUtil.new
		tmp_repo_path = @file_util.setup_tmp_repo_dir
		@report_generator = ReportGenerator.new tmp_repo_path
	end

	def teardown
		@file_util.remove_tmp_repo_dir
	end

	def test_get_repo_names
		repos = @report_generator.get_repo_names
		assert_equal('test-repo-1', repos[0])
		assert_equal('test-repo-2', repos[1])
		assert_equal(2, repos.count)
	end

	def test_get_master_branches_not_merged_to_develop
		branch_names = @report_generator.get_master_branches_not_merged_to_develop
		assert_equal('test-repo-1 master', branch_names[0])
		assert_equal(1, branch_names.count)
	end

	def test_get_release_branches_not_merged_to_develop
		branch_names = @report_generator.get_release_branches_not_merged_to_develop
		assert_equal('test-repo-1 release/first-release', branch_names[0])
		assert_equal('test-repo-2 release/first-release', branch_names[1])
		assert_equal(2, branch_names.count)
	end

	def test_get_release_branches_not_merged_to_master
		branch_names = @report_generator.get_release_branches_not_merged_to_master
		assert_equal('test-repo-1 release/first-release', branch_names[0])
		assert_equal('test-repo-2 release/first-release', branch_names[1])
		assert_equal('test-repo-2 release/second-release', branch_names[2])
		assert_equal(3, branch_names.count)
	end

	def test_get_hotfix_branches_not_merged_to_develop
		branch_names = @report_generator.get_hotfix_branches_not_merged_to_develop
		assert_equal('test-repo-1 hotfix/first-hotfix', branch_names[0])
		assert_equal(1, branch_names.count)
	end

	def test_get_hotfix_branches_not_merged_to_master
		branch_names = @report_generator.get_hotfix_branches_not_merged_to_master
		assert_equal('test-repo-1 hotfix/first-hotfix', branch_names[0])
		assert_equal(1, branch_names.count)
	end

	def test_get_merged_feature_branches
		branch_names = @report_generator.get_merged_feature_branches
		assert_equal('test-repo-1 feature/TICKET-123', branch_names[0])
		assert_equal(1, branch_names.count)
	end

	def test_get_unmerged_feature_branches
		branch_names = @report_generator.get_unmerged_feature_branches
		assert_equal('test-repo-1 feature/TICKET-1337', branch_names[0])
		assert_equal(1, branch_names.count)
	end
end