require 'test/unit'
require_relative '../git_output_parser.rb'
require_relative '../models/branch.rb'

class TestGitOutputParser < Test::Unit::TestCase
	def test_parse_brach_info

		git_output = <<-eos
145567e andwin        Tue Oct 8 22:36:48 2013 +0200   updated documentation
245567e andwin        Tue Oct 7 22:35:48 2013 +0200   critical bugfix
345567e andwin        Tue Oct 6 22:34:48 2013 +0200   added important feature
445567e andwin        Tue Oct 5 22:33:48 2013 +0200   Initial commit
eos
		
		branch = GitOutputParser.parse_brach_info 'branch', 'repo', git_output
		
		last_commit_date = Date.parse git_output.lines[0]
		days_ago = (Date.today - last_commit_date).to_i

		assert_equal 'branch', branch.name
		assert_equal 'repo', branch.repo_name
		assert_equal 4, branch.number_of_unmerged_commits
		assert_not_nil branch.unmerged_commits
		assert_equal 4, branch.unmerged_commits.count
		assert_equal '145567e andwin        Tue Oct 8 22:36:48 2013 +0200   updated documentation', branch.unmerged_commits[0]
		assert_equal days_ago, branch.days_since_last_commit
	end
end
