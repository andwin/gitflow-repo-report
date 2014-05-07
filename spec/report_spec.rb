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
end