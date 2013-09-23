class Report
	attr_accessor :repos
	attr_accessor :old_feature_branches
	attr_accessor :unmerged_releasebranches
	attr_accessor :master_branch_with_commits_missing_from_develop

	def initialize
		@repos = Array.new
		@old_feature_branches = Array.new
		@unmerged_releasebranches = Array.new
		@master_branch_with_commits_missing_from_develop = Array.new
	end

end