require 'yaml'
require_relative 'models/report.rb'
require_relative 'git_output_parser.rb'

class ReportGenerator
	def initialize(repo_path)
		@repo_path = repo_path
	end

	def generate_report reports_path
		update_repos
		time = Time.new

		report = Report.new
		report.time = time
		report.repo_names = get_repo_names
		report.master_branches_not_merged_to_develop = get_master_branches_not_merged_to_develop
		report.release_branches_not_merged_to_develop = get_release_branches_not_merged_to_develop
		report.release_branches_not_merged_to_master = get_release_branches_not_merged_to_master
		report.hotfix_branches_not_merged_to_develop = get_hotfix_branches_not_merged_to_develop
		report.hotfix_branches_not_merged_to_master = get_hotfix_branches_not_merged_to_master
		report.merged_feature_branches = get_merged_feature_branches
		report.unmerged_feature_branches = get_unmerged_feature_branches

		file_name = File.join(reports_path, time.strftime("%Y-%m-%d_%H-%M-%S") + '.yaml')

		File.open(file_name, 'w') do |file|  
		  file.puts YAML::dump(report)
		end  
	end

	def update_repos
		get_repo_names.each do |repo_name|
			repo_path = get_repo_path repo_name
			`git --git-dir=#{repo_path} fetch --prune`
		end
	end

	def get_repo_names
		repo_names = []
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_names.push File.basename repo_path
		end
		repo_names.sort
	end

	def get_repo_path repo_name
		path = File.join(@repo_path, repo_name, '.git')

		return path if Dir.exists? path

		File.join(@repo_path, repo_name)
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

	def get_hotfix_branches_not_merged_to_develop
		get_branches_with_diffs 'hotfix/', 'develop'
	end

	def get_hotfix_branches_not_merged_to_master
		get_branches_with_diffs 'hotfix/', 'master'
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
			branches = get_branches(repo_name).select { |branch| branch.start_with? branch1 }
			branches.each do |branch|
				branch = get_branch_model(repo_name, branch, branch2)
				if branch.number_of_unmerged_commits > 0 == look_for_merged_branches
					branch_names.push branch
				end
			end
		end
		branch_names
	end

	def get_branches repo_name
		repo_path = get_repo_path repo_name
		branches =`git --git-dir=#{repo_path} branch`
		branches.gsub("*", "").gsub(" ", "").split("\n")
	end

	def get_branch_model repo_name, branch1, branch2
		repo_path = get_repo_path repo_name
		git_output = `git --git-dir=#{repo_path} log #{branch1} ^#{branch2} --no-merges --pretty=format:"%h%x09%an%x09%ad%x09%s"`

		branch = GitOutputParser.parse_brach_info branch1, repo_name, git_output
		branch
	end
end