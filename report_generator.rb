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
end