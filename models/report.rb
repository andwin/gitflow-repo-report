class Report
	attr_accessor :date
	attr_accessor :repos
	attr_accessor :old_feature_branches
	attr_accessor :unmerged_release_branches
	attr_accessor :master_branches_with_commits_missing_from_develop

	def initialize
		@repos = Array.new
		@old_feature_branches = Array.new
		@unmerged_release_branches = Array.new
		@master_branches_with_commits_missing_from_develop = Array.new
	end
end