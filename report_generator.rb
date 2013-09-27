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
end