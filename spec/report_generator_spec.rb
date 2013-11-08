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

  context "result of call to get_repo_names" do
    before(:all) do
      @repos = @report_generator.get_repo_names
    end

    it "should include test-repo 1 and 2" do
      expect(@repos).to include 'test-repo-1'
      expect(@repos).to include 'test-repo-2'
    end

    it "should contain exactly 2 repos" do
      expect(@repos.count).to eq 2
    end
  end
end