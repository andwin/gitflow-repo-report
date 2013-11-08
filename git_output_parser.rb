require 'date'
require 'time'
require_relative 'models/branch.rb'
require_relative 'models/commit.rb'

class GitOutputParser

  # Parse output from git log --pretty=format:"%h%x09%an%x09%ad%x09%s"
  #
  # 145567e	andwin	Tue Oct 8 22:36:48 2013 +0200	updated documentation
  # 245567e	andwin	Tue Oct 7 22:35:48 2013 +0200	critical bugfix
  # 345567e	andwin	Tue Oct 6 22:34:48 2013 +0200	added important feature
  # 445567e	andwin	Tue Oct 5 22:33:48 2013 +0200	Initial commit
  def self.parse_branch_info branch_name, repo_name, git_output
    branch = Branch.new
    branch.repo_name = repo_name
    branch.name = branch_name
    branch.number_of_unmerged_commits = git_output.lines.count
    branch.unmerged_commits = git_output.lines.map{ |x| parse_output_line_to_commit_model x }

    if branch.unmerged_commits[0]
      branch.days_since_last_commit = parse_days_since_last_commit branch.unmerged_commits[0].time
    end

    branch
  end

  private

  def self.parse_output_line_to_commit_model git_output_line
    commit = Commit.new
    parts = git_output_line.split /^(\w*)\t([^\t]*)\t([^\t]*)\t(.*)$/

    commit.id = parts[1]
    commit.author = parts[2]
    commit.time = Time.parse parts[3]
    commit.message = parts[4]
    commit
  end

  def self.parse_days_since_last_commit last_commit_time
    days_ago = (Time.now - last_commit_time).to_i / 86400
  end
end