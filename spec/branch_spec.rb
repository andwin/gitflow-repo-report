require 'rspec'
require_relative '../report_generator.rb'
require_relative 'test_utils.rb'

describe Branch do
  it 'should be equal' do
    branch1 = Branch.new
    branch1.name = 'feature/TICKET-1'
    branch1.repo_name = 'repo1'

    branch2 = Branch.new
    branch2.name = 'feature/TICKET-1'
    branch2.repo_name = 'repo1'

    branch1.should eq branch2
  end

  it 'should not be equal' do
    branch1 = Branch.new
    branch1.name = 'feature/TICKET-1'
    branch1.repo_name = 'repo1'

    branch2 = Branch.new
    branch2.name = 'feature/TICKET-1'
    branch2.repo_name = 'repo2'

    branch1.should_not eq branch2
  end

  it 'should work with the AND operator' do
    branch_a1 = Branch.new
    branch_a1.name = 'feature/TICKET-1'
    branch_a1.repo_name = 'repo1'

    branch_a2 = Branch.new
    branch_a2.name = 'feature/TICKET-1'
    branch_a2.repo_name = 'repo2'

    branch_b1 = Branch.new
    branch_b1.name = 'feature/TICKET-1'
    branch_b1.repo_name = 'repo3'

    branch_b2 = Branch.new
    branch_b2.name = 'feature/TICKET-1'
    branch_b2.repo_name = 'repo1'

    branches1 = [branch_a1, branch_a2]
    branches2 = [branch_b1, branch_b2]

    common = branches1 & branches2

    common.count.should eq 1
    common[0].name.should eq 'feature/TICKET-1'
    common[0].repo_name.should eq 'repo1'
  end

end