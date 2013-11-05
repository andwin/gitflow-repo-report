require 'test/unit'
require_relative '../models/branch.rb'

class TestGitOutputParser < Test::Unit::TestCase

  def test_branches_are_equal
    branch1 = Branch.new
    branch1.name = 'feature/TICKET-1'
    branch1.repo_name = 'repo1'

    branch2 = Branch.new
    branch2.name = 'feature/TICKET-1'
    branch2.repo_name = 'repo1'

    assert_equal branch1, branch2
  end

  def test_branches_are_not_equal
    branch1 = Branch.new
    branch1.name = 'feature/TICKET-1'
    branch1.repo_name = 'repo1'

    branch2 = Branch.new
    branch2.name = 'feature/TICKET-1'
    branch2.repo_name = 'repo2'

    assert_not_equal branch1, branch2
  end

  def test_compare_arrays_of_branches
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

    assert_equal 1, common.count
    assert_equal 'feature/TICKET-1', common[0].name
    assert_equal 'repo1', common[0].repo_name
  end
end