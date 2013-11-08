require 'test/unit'
require 'time'
require_relative '../git_output_parser.rb'
require_relative '../models/branch.rb'
require_relative '../models/commit.rb'

class TestGitOutputParser < Test::Unit::TestCase
  def test_parse_brach_info

    git_output = <<-eos
145567e	andwin	Tue Oct 8 22:36:48 2013 +0200	updated documentation
245567e	andwin	Tue Oct 7 22:35:48 2013 +0200	critical bugfix
345567e	andwin	Tue Oct 6 22:34:48 2013 +0200	added important feature
445567e	andwin	Tue Oct 5 22:33:48 2013 +0200	Initial commit
eos

    time_str = 'Tue Oct 8 22:36:48 2013 +0200'

    branch = GitOutputParser.parse_branch_info 'branch', 'repo', git_output

    last_commit_time = Time.parse time_str
    days_ago = (Time.now - last_commit_time).to_i / 86400

    assert_equal 'branch', branch.name
    assert_equal 'repo', branch.repo_name
    assert_equal 4, branch.number_of_unmerged_commits
    assert_not_nil branch.unmerged_commits
    assert_equal 4, branch.unmerged_commits.count

    last_commit = branch.unmerged_commits[0]

    assert_instance_of Commit, last_commit
    assert_equal '145567e', last_commit.id
    assert_equal 'andwin', last_commit.author
    assert_equal last_commit_time, last_commit.time
    assert_equal 'updated documentation', last_commit.message

    assert_equal days_ago, branch.days_since_last_commit
  end
end