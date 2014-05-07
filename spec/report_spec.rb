require 'rspec'
require_relative '../models/report.rb'
require_relative '../models/branch.rb'

describe Report do
  it 'calculates total_number_of_branches' do
    branch1 = Branch.new
    branch1.repo_name = 'repo1'
    branch1.name = 'feature/ID-123'

    branch2 = Branch.new
    branch2.repo_name = 'repo2'
    branch2.name = 'release/2014-04-04'

    report = Report.new
    report.release_branches_not_merged_to_develop = []
    report.release_branches_not_merged_to_develop.push branch1
    report.release_branches_not_merged_to_develop.push branch2

    report.release_branches_not_merged_to_master = []
    report.release_branches_not_merged_to_master.push branch1

    report.total_number_of_branches.should eq 2
  end

  it 'calculates total_number_of_unmerged_commits' do
    branch1 = Branch.new
    branch1.repo_name = 'repo1'
    branch1.name = 'feature/ID-123'
    branch1.number_of_unmerged_commits = 4

    branch2 = Branch.new
    branch2.repo_name = 'repo2'
    branch2.name = 'release/2014-04-04'
    branch2.number_of_unmerged_commits = 3

    report = Report.new
    report.release_branches_not_merged_to_develop = []
    report.release_branches_not_merged_to_develop.push branch1
    report.release_branches_not_merged_to_develop.push branch2

    report.release_branches_not_merged_to_master = []
    report.release_branches_not_merged_to_master.push branch1

    report.total_number_of_unmerged_commits.should eq 7
  end

  it 'finds the brach with most unmerged commits' do
    branch1 = Branch.new
    branch1.repo_name = 'repo1'
    branch1.name = 'feature/ID-123'
    branch1.number_of_unmerged_commits = 4

    branch2 = Branch.new
    branch2.repo_name = 'repo2'
    branch2.name = 'release/2014-04-04'
    branch2.number_of_unmerged_commits = 3

    report = Report.new
    report.release_branches_not_merged_to_develop = []
    report.release_branches_not_merged_to_develop.push branch1
    report.release_branches_not_merged_to_develop.push branch2

    report.release_branches_not_merged_to_master = []
    report.release_branches_not_merged_to_master.push branch1

    report.branch_with_most_unmerged_commits.should eq 'repo1 feature/ID-123 4'
  end
end