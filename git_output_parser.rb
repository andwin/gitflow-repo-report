require_relative 'models/branch.rb'
class GitOutputParser

	# Parse output from git log --pretty=format:"%h%x09%an%x09%ad%x09%s"
	#
	# 145567e andwin        Tue Oct 8 22:36:48 2013 +0200   updated documentation
	# 245567e andwin        Tue Oct 7 22:35:48 2013 +0200   critical bugfix
	# 345567e andwin        Tue Oct 6 22:34:48 2013 +0200   added important feature
	# 445567e andwin        Tue Oct 5 22:33:48 2013 +0200   Initial commit
	def self.parse_brach_info branch_name, repo_name, git_output
		branch = Branch.new
		branch.repo_name = repo_name
		branch.name = branch_name
		branch.number_of_unmerged_commits = git_output.lines.count
		branch.unmerged_commits = git_output.lines.map{ |x| x.strip }

		branch
	end
end