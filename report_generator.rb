require 'grit'
require_relative 'models/report.rb'

class ReportGenerator

	def initialize(repo_path)
		@repo_path = repo_path
	end

	def get_repos
		repos = Array.new

		Dir.glob(File.join(@repo_path, '*')) do |repo|
			repos.push File.basename repo
		end

		repos
	end

	def get_branch_names
		branch_names = Array.new
		Dir.glob(File.join(@repo_path, '*')) do |repo|
			repoName = File.basename repo
			gritRepo = Grit::Repo.new(repo)
			branch_names.concat gritRepo.heads().map { |a| repoName + " " << a.name }
		end
		branch_names
	end
end