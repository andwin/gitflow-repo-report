require_relative '../report_generator.rb'
require_relative 'test_helper.rb'

class TestReportGenerator < Test::Unit::TestCase
	def setup
		tmp_repo_path = setup_tmp_repo_dir
		@report_generator = ReportGenerator.new File.join(tmp_repo_path, 'test_repos')
	end

	def teardown
		remove_tmp_repo_dir
	end

	def test_get_repo_names
		repos = @report_generator.get_repo_names
		assert_equal('test-repo-1', repos[0])
		assert_equal('test-repo-2', repos[1])
		assert_equal(2, repos.count)
	end

	def test_get_branch_names
		branch_names = @report_generator.get_branch_names
		assert_equal('test-repo-1 develop', branch_names[0])
		assert_equal('test-repo-2 release/second-release', branch_names[8])
		assert_equal(9, branch_names.count)
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
end