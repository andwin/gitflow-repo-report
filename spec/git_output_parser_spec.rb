require 'rspec'
require 'time'
require_relative '../git_output_parser.rb'
require_relative '../models/branch.rb'
require_relative '../models/commit.rb'

describe GitOutputParser do
  it 'parses branch info correctly' do

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

    branch.name.should eq 'branch'
    branch.repo_name.should eq 'repo'
    branch.number_of_unmerged_commits.should eq 4
    branch.unmerged_commits.should_not be_nil
    branch.unmerged_commits.count.should eq 4

    last_commit = branch.unmerged_commits[0]

    last_commit.should be_an_instance_of Commit
    last_commit.id.should eq '145567e'
    last_commit.author.should eq 'andwin'
    last_commit.time.should eq last_commit_time
    last_commit.message.should eq 'updated documentation'

    branch.days_since_last_commit.should equal days_ago
  end
end