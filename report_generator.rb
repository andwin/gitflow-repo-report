require 'yaml'
require_relative 'models/report.rb'

class ReportGenerator
	def initialize(repo_path)
		@repo_path = repo_path
	end

	def generate_report reports_path
		time = Time.new

		report = Report.new
		report.time = time
		report.repo_names = get_repo_names
		report.master_branches_not_merged_to_develop = get_master_branches_not_merged_to_develop
		report.release_branches_not_merged_to_develop = get_release_branches_not_merged_to_develop
		report.release_branches_not_merged_to_master = get_release_branches_not_merged_to_master
		report.merged_feature_branches = get_merged_feature_branches
		report.unmerged_feature_branches = get_unmerged_feature_branches

		file_name = File.join(reports_path, time.strftime("%Y-%m-%d_%H-%M-%S") + '.yaml')

		File.open(file_name, 'w') do |file|  
		  file.puts YAML::dump(report)
		end  
	end

	def get_repo_names
		repo_names = []
		Dir.glob(File.join(@repo_path, '*')) do |repo_path|
			repo_names.push File.basename repo_path
		end
		repo_names.sort
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
		pwd = Dir.pwd
		branch_names = []
		get_repo_names.each do |repo_name|
			Dir.chdir(File.join(@repo_path, repo_name))
			branches = get_branches
			branches = get_branches.select { |branch| branch.start_with? branch1 }
			branches.each do |branch|
				if branches_diff?(branch, branch2) == look_for_merged_branches
					branch_names.push repo_name + " " + branch
				end
			end
			Dir.chdir(pwd)
		end
		branch_names
	end

	def get_branches
		branches =`git branch`
		branches.gsub("*", "").gsub(" ", "").split("\n")
	end

	def branches_diff? branch1, branch2
		commit_count = `git log #{branch1} ^#{branch2} --pretty=oneline | wc -l`
		commit_count.strip != '0'
	end
end