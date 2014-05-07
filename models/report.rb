class Report
  attr_accessor :time
  attr_accessor :repo_names
  attr_accessor :master_branches_not_merged_to_develop
  attr_accessor :release_branches_not_merged_to_develop
  attr_accessor :release_branches_not_merged_to_master
  attr_accessor :release_branches_merged_to_master_and_develop
  attr_accessor :hotfix_branches_not_merged_to_develop
  attr_accessor :hotfix_branches_not_merged_to_master
  attr_accessor :hotfix_branches_merged_to_master_and_develop
  attr_accessor :merged_feature_branches
  attr_accessor :unmerged_feature_branches

  def initialize
    @master_branches_not_merged_to_develop = []
    @release_branches_not_merged_to_develop = []
    @release_branches_not_merged_to_master = []
    @release_branches_merged_to_master_and_develop = []
    @hotfix_branches_not_merged_to_develop = []
    @hotfix_branches_not_merged_to_master = []
    @hotfix_branches_merged_to_master_and_develop = []
    @merged_feature_branches = []
    @unmerged_feature_branches = []
  end

  def total_number_of_branches
    all_branches = master_branches_not_merged_to_develop |
      release_branches_not_merged_to_develop |
      release_branches_not_merged_to_master |
      release_branches_merged_to_master_and_develop |
      hotfix_branches_not_merged_to_develop |
      hotfix_branches_not_merged_to_master |
      hotfix_branches_merged_to_master_and_develop |
      merged_feature_branches |
      unmerged_feature_branches

    all_branches.count
  end

  def total_number_of_unmerged_commits
    all_branches = master_branches_not_merged_to_develop |
      release_branches_not_merged_to_develop |
      release_branches_not_merged_to_master |
      release_branches_merged_to_master_and_develop |
      hotfix_branches_not_merged_to_develop |
      hotfix_branches_not_merged_to_master |
      hotfix_branches_merged_to_master_and_develop |
      merged_feature_branches |
      unmerged_feature_branches

    total_number_of_unmerged_commits = 0
    all_branches.each do |branch|
      total_number_of_unmerged_commits += branch.number_of_unmerged_commits
    end

    total_number_of_unmerged_commits
  end
end