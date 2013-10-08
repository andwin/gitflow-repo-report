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

	def get_master_branches_not_merged_to_develop
		get_branches_with_diffs 'master', 'develop'
	end

	def get_release_branches_not_merged_to_develop
		get_branches_with_diffs 'release/', 'develop'
	end

	def get_release_branches_not_merged_to_master
		get_branches_with_diffs 'release/', 'master'
	end

	def get_merged_feature_branches
		get_branches_with_diffs 'feature/', 'develop', false
	end

	def get_unmerged_feature_branches
		get_branches_with_diffs 'feature/', 'develop'
	end

	private

	def get_branches_with_diffs branch1, branch2, look_for_merged_branches = true
		branch_names = []
		get_repo_names.each do |repo_name|
			repo = get_repo repo_name
			branches = repo.branches.select { |branch| branch.name.start_with? branch1 }
			branches.each do |branch|
				if branches_diff?(branch.name, branch2) == look_for_merged_branches
					branch_names.push repo_name + " " + branch.name
				end
			end
		end
		branch_names		
	end

	def get_repo repo_name
		repo_path = File.join(@repo_path, repo_name)
		Git.open(repo_path)
	end

	def branches_diff? branch1, branch2
		commit_count = `git log #{branch1} ^#{branch2} --pretty=oneline | wc -l`
		commit_count.strip != '0'
	end
end