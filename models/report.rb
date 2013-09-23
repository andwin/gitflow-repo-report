class Report
	attr_accessor :date
	attr_accessor :repos
	attr_accessor :old_feature_branches
	attr_accessor :unmerged_release_branches
	attr_accessor :repos_with_unmerged_master_branch

	def initialize
		@repos = Array.new
		@old_feature_branches = Array.new
		@unmerged_release_branches = Array.new
		@repos_with_unmerged_master_branch = Array.new
	end
end