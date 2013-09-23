class Report
	attr_accessor :repos
	attr_accessor :old_feature_brances
	attr_accessor :unmerged_releasebrances
	attr_accessor :master_branch_with_commits_missing_from_develop

	def initialize
		@repos = Array.new
		@old_feature_brances = Array.new
		@unmerged_releasebrances = Array.new
		@master_branch_with_commits_missing_from_develop = Array.new
	end

end