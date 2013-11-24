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

  context 'result of call to get_repo_names' do
    before(:all) do
      @repos = @report_generator.get_repo_names
    end

    it 'should contain 2 repos' do
      expect(@repos.count).to eq 2
    end

    it 'should include test-repo 1 and 2' do
      expect(@repos).to include 'test-repo-1'
      expect(@repos).to include 'test-repo-2'
    end
  end

  context 'result of call to get_master_branches_not_merged_to_develop' do
    before(:all) do
      @branches = @report_generator.get_master_branches_not_merged_to_develop
    end

    it 'should contain 1 branch' do
      expect(@branches.count).to eq 1
    end

    it 'should be the master branch from test-repo-1' do
      expect(@branches[0].name).to eq 'master'
      expect(@branches[0].repo_name).to eq 'test-repo-1'
    end
  end

  context 'result of call to get_release_branches_not_merged_to_develop' do
    before(:all) do
      @branches = @report_generator.get_release_branches_not_merged_to_develop
    end

    it 'should contain 2 branches' do
      expect(@branches.count).to eq 2
    end

    it 'should include the branch release/first-release from the repo test-repo-1' do
      expect(@branches[0].repo_name).to eq 'test-repo-1'
      expect(@branches[0].name).to eq 'release/first-release'
    end

    it 'should include the branch release/first-release from the repo test-repo-1' do
      expect(@branches[1].repo_name).to eq 'test-repo-2'
      expect(@branches[1].name).to eq 'release/first-release'
    end
  end
end