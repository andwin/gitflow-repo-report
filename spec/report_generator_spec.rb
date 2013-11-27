require 'rspec'
require_relative '../report_generator.rb'
require_relative 'test_utils.rb'


describe ReportGenerator do
  before(:all) do
    @test_utils = TestUtils.new
    @test_utils.setup_tmp_dir
    @report_generator = ReportGenerator.new @test_utils.tmp_repos_path
  end

  after(:all) do
    @test_utils.cleanup_tmp_dir
  end

  context 'release branches not merged to master' do
    before(:all) do
      @branches = @report_generator.get_release_branches_not_merged_to_master
    end

    it 'should include two branches' do
      @branches.count.should eq 2
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-1', 'release/first-release'
      should_include_branch @branches, 'test-repo-2', 'release/first-release'
    end
  end

  context 'release branches merged to master and develop' do
    before(:all) do
      @branches = @report_generator.get_release_branches_merged_to_master_and_develop
    end

    it 'should include 4 branches' do
      @branches.count.should eq 4
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-1', 'release/second-release'
      should_include_branch @branches, 'test-repo-1', 'release/third-release'
      should_include_branch @branches, 'test-repo-2', 'release/second-release'
      should_include_branch @branches, 'test-repo-2', 'release/third-release'
    end
  end

  context 'hotfix branches not merged to develop' do
    before(:all) do
      @branches = @report_generator.get_hotfix_branches_not_merged_to_develop
    end

    it 'should include 2 branches' do
      @branches.count.should eq 2
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-1', 'hotfix/first-hotfix'
      should_include_branch @branches, 'test-repo-1', 'hotfix/second-hotfix'
    end
  end

  context 'hotfix branches not merged to master' do
    before(:all) do
      @branches = @report_generator.get_hotfix_branches_not_merged_to_master
    end

    it 'should include 1 branches' do
      @branches.count.should eq 1
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-1', 'hotfix/first-hotfix'
    end
  end

  context 'hotfix branches merged to master and develop' do
    before(:all) do
      @branches = @report_generator.get_hotfix_branches_merged_to_master_and_develop
    end

    it 'should include 1 branches' do
      @branches.count.should eq 2
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-2', 'hotfix/first-hotfix'
      should_include_branch @branches, 'test-repo-2', 'hotfix/second-hotfix'
    end
  end

  context 'merged feature branches' do
    before(:all) do
      @branches = @report_generator.get_merged_feature_branches
    end

    it 'should include 1 branches' do
      @branches.count.should eq 1
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-1', 'feature/TICKET-123'
    end
  end

  context 'unmerged feature branches' do
    before(:all) do
      @branches = @report_generator.get_unmerged_feature_branches
    end

    it 'should include 1 branches' do
      @branches.count.should eq 1
    end

    it 'should include the expected branches' do
      should_include_branch @branches, 'test-repo-1', 'feature/TICKET-1337'
    end
  end

  def should_include_branch branches, repo_name, branch_name
    branch = Branch.new
    branch.repo_name = repo_name
    branch.name = branch_name

    expect(branches).to include branch
  end
end