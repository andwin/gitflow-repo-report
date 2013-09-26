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

	def test_get_repos
		repos = @report_generator.get_repos
		assert_equal('test-repo-1', repos[0])
		assert_equal('test-repo-2', repos[1])
		assert_equal(2, repos.count)
	end

end