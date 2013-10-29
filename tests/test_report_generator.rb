require 'test/unit'
require_relative '../report_generator.rb'
require_relative 'test_utils.rb'

class TestReportGenerator < Test::Unit::TestCase
	def setup
		@test_utils = TestUtils.new
		@test_utils.setup_tmp_dir
		@report_generator = ReportGenerator.new @test_utils.tmp_repos_path
	end

	def teardown
		@test_utils.cleanup_tmp_dir
	end

	def test_get_repo_names
		repos = @report_generator.get_repo_names
		assert_equal 'test-repo-1', repos[0]
		assert_equal 'test-repo-2', repos[1]
		assert_equal 2, repos.count
	end

	def test_get_master_branches_not_merged_to_develop
		branches = @report_generator.get_master_branches_not_merged_to_develop
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'master', branches[0].name
		assert_equal 1, branches.count
	end

	def test_get_release_branches_not_merged_to_develop
		branches = @report_generator.get_release_branches_not_merged_to_develop
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'release/first-release', branches[0].name
		assert_equal 'test-repo-2', branches[1].repo_name
		assert_equal 'release/first-release', branches[1].name
		assert_equal 2, branches.count
	end

	def test_get_release_branches_not_merged_to_master
		branches = @report_generator.get_release_branches_not_merged_to_master
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'release/first-release', branches[0].name
		assert_equal 'test-repo-2', branches[1].repo_name
		assert_equal 'release/first-release', branches[1].name
		assert_equal 2, branches.count
	end

	def test_get_release_branches_merged_to_master_and_develop
		branches = @report_generator.get_release_branches_merged_to_master_and_develop
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'release/second-release', branches[0].name
		assert_equal 'test-repo-1', branches[1].repo_name
		assert_equal 'release/third-release', branches[1].name
		assert_equal 'test-repo-2', branches[2].repo_name
		assert_equal 'release/second-release', branches[2].name
		assert_equal 'test-repo-2', branches[3].repo_name
		assert_equal 'release/third-release', branches[3].name
		assert_equal 4, branches.count
	end

	def test_get_hotfix_branches_not_merged_to_develop
		branches = @report_generator.get_hotfix_branches_not_merged_to_develop
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'hotfix/first-hotfix', branches[0].name
		assert_equal 'test-repo-1', branches[1].repo_name
		assert_equal 'hotfix/second-hotfix', branches[1].name
		assert_equal 2, branches.count
	end

	def test_get_hotfix_branches_not_merged_to_master
		branches = @report_generator.get_hotfix_branches_not_merged_to_master
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'hotfix/first-hotfix', branches[0].name
		assert_equal 1, branches.count
	end

	def test_get_hotfix_branches_merged_to_master_and_develop
		branches = @report_generator.get_hotfix_branches_merged_to_master_and_develop
		assert_equal 'test-repo-2', branches[0].repo_name
		assert_equal 'hotfix/first-hotfix', branches[0].name
		assert_equal 'test-repo-2', branches[1].repo_name
		assert_equal 'hotfix/second-hotfix', branches[1].name
		assert_equal 2, branches.count
	end

	def test_get_merged_feature_branches
		branches = @report_generator.get_merged_feature_branches
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'feature/TICKET-123', branches[0].name
		assert_equal 1, branches.count
	end

	def test_get_unmerged_feature_branches
		branches = @report_generator.get_unmerged_feature_branches
		assert_equal 'test-repo-1', branches[0].repo_name
		assert_equal 'feature/TICKET-1337', branches[0].name
		assert_equal 1, branches.count
	end
end