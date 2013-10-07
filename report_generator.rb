require 'git'
require_relative 'models/report.rb'

class ReportGenerator

	def initialize(repo_path)
		@repo_path = repo_path
	end

	def get_repos
		repos = Array.new

		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repos.push File.basename repo_path
		end

		repos
	end

	def get_branch_names
		branch_names = Array.new
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_name = File.basename repo_path
			git_repo = Git.open(repo_path)
			branch_names.concat git_repo.branches().map { |a| repo_name + " " << a.name }
		end
		branch_names
	end

	def get_release_branches_not_merged_to_develop
		branch_names = Array.new
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_name = File.basename repo_path
			git_repo = Git.open(repo_path)
			git_repo.branches().each do |branch|
				if branch.name.start_with? 'release/'
					commit_count = `git log #{branch.name} ^develop --pretty=oneline | wc -l`
					if commit_count.strip != '0'
						branch_names.push repo_name + " " + branch.name
					end
				end
			end
		end
		branch_names
	end

	def get_release_branches_not_merged_to_master
		branch_names = Array.new
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_name = File.basename repo_path
			git_repo = Git.open(repo_path)
			git_repo.branches().each do |branch|
				if branch.name.start_with? 'release/'
					commit_count = `git log #{branch.name} ^master --pretty=oneline | wc -l`
					if commit_count.strip != '0'
						branch_names.push repo_name + " " + branch.name
					end
				end
			end
		end
		branch_names
	end

end