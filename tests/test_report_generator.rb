require_relative '../report-generator.rb'
require_relative 'test_helper.rb'

class TestReportGenerator < Test::Unit::TestCase

	def setup
		tmp_repo_path = setup_tmp_repo_dir
		@report_generator = ReportGenerator.new File.join(tmp_repo_path, 'test-repos')
	end

	def teardown
		remove_tmp_repo_dir
	end

	def test_get_repos
		repos = @report_generator.get_repos
		assert_equal('test-repo-1', repos[0])
		assert_equal('test-repo-2', repos[1])
		assert_equal(2, repos.count)
	end

	def test_get_branch_names
		branch_names = @report_generator.get_branch_names
		assert_equal('test-repo-1 develop', branch_names[0])
		assert_equal('test-repo-2 release/second-release', branch_names[6])
		assert_equal(7, branch_names.count)
	end

end