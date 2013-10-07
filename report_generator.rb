require 'git'
require_relative 'models/report.rb'

class ReportGenerator
	def initialize(repo_path)
		@repo_path = repo_path
	end

	def get_repo_names
		repo_names = []
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_names.push File.basename repo_path
		end
		repo_names
	end

	def get_branch_names
		branch_names = []
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_name = File.basename repo_path
			git_repo = Git.open(repo_path)
			branch_names.concat git_repo.branches().map { |a| repo_name + " " << a.name }
		end
		branch_names
	end

	def get_release_branches_not_merged_to_develop
		branch_names = []
		get_repo_names.each do |repo_name|
			repo = get_repo repo_name
			branches = repo.branches.select { |branch| branch.name.start_with? 'release/' }
			branches.each do |branch|
				commit_count = `git log #{branch.name} ^develop --pretty=oneline | wc -l`
				if commit_count.strip != '0'
					branch_names.push repo_name + " " + branch.name
				end
			end
		end
		branch_names
	end

	def get_release_branches_not_merged_to_master
		branch_names = []
		get_repo_names.each do |repo_name|
			repo = get_repo repo_name
			branches = repo.branches.select { |branch| branch.name.start_with? 'release/' }
			branches.each do |branch|
				commit_count = `git log #{branch.name} ^master --pretty=oneline | wc -l`
				if commit_count.strip != '0'
					branch_names.push repo_name + " " + branch.name
				end
			end
		end
		branch_names
	end

	private

	def get_repo repo_name
		repo_path = File.join(@repo_path, repo_name)
		Git.open(repo_path)
	end

end