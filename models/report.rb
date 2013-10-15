class Report
	attr_accessor :time
	attr_accessor :repo_names
	attr_accessor :master_branches_not_merged_to_develop
	attr_accessor :release_branches_not_merged_to_develop
	attr_accessor :release_branches_not_merged_to_master
	attr_accessor :hotfix_branches_not_merged_to_develop
	attr_accessor :hotfix_branches_not_merged_to_master
	attr_accessor :merged_feature_branches
	attr_accessor :unmerged_feature_branches
end