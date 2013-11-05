require 'yaml'
require_relative 'models/report.rb'
require_relative 'git_output_parser.rb'

class ReportGenerator
  def initialize repos_path
    @repos_path = repos_path
  end

  def generate_report reports_path
    update_repos
    time = Time.new

    report = Report.new
    report.time = time
    report.repo_names = get_repo_names
    report.master_branches_not_merged_to_develop = get_master_branches_not_merged_to_develop
    report.release_branches_not_merged_to_develop = get_release_branches_not_merged_to_develop
    report.release_branches_not_merged_to_master = get_release_branches_not_merged_to_master
    report.release_branches_merged_to_master_and_develop = get_release_branches_merged_to_master_and_develop
    report.hotfix_branches_not_merged_to_develop = get_hotfix_branches_not_merged_to_develop
    report.hotfix_branches_not_merged_to_master = get_hotfix_branches_not_merged_to_master
    report.hotfix_branches_merged_to_master_and_develop = get_hotfix_branches_merged_to_master_and_develop
    report.merged_feature_branches = get_merged_feature_branches
    report.unmerged_feature_branches = get_unmerged_feature_branches

    file_name = File.join(reports_path, time.strftime("%Y-%m-%d_%H-%M-%S") + '.yaml')

    File.open(file_name, 'w') do |file|
      file.puts YAML::dump(report)
    end
  end

  def update_repos
    get_repo_names.each do |repo_name|
      repo_path = get_repo_path repo_name
      `git --git-dir=#{repo_path} fetch --prune`
    end
  end

  def get_repo_names
    repo_names = []
    Dir.glob(File.join(@repos_path, '*')) do |repo_path|
      repo_names.push File.basename repo_path
    end
    repo_names.sort
  end

  # Return the full path to the git directory in the repo.
  # If there is no .git repo, it is probably a bare repository and the path to the repo is returned instead.
  def get_repo_path repo_name
    path = File.join(@repos_path, repo_name, '.git')

    return path if Dir.exists? path

    File.join(@repos_path, repo_name)
  end

  def get_master_branches_not_merged_to_develop
    get_unmerged_branches 'master', 'develop'
  end

  def get_release_branches_not_merged_to_develop
    get_unmerged_branches 'release/', 'develop'
  end

  def get_release_branches_not_merged_to_master
    get_unmerged_branches 'release/', 'master'
  end

  def get_release_branches_merged_to_master_and_develop
    branches_merged_to_master = get_merged_branches 'release/', 'master'
    branches_merged_to_develop = get_merged_branches 'release/', 'develop'

    return branches_merged_to_master & branches_merged_to_develop
  end

  def get_hotfix_branches_not_merged_to_develop
    get_unmerged_branches 'hotfix/', 'develop'
  end

  def get_hotfix_branches_not_merged_to_master
    get_unmerged_branches 'hotfix/', 'master'
  end

  def get_hotfix_branches_merged_to_master_and_develop
    branches_merged_to_master = get_merged_branches 'hotfix/', 'master'
    branches_merged_to_develop = get_merged_branches 'hotfix/', 'develop'

    return branches_merged_to_master & branches_merged_to_develop
  end

  def get_merged_feature_branches
    get_merged_branches 'feature/', 'develop'
  end

  def get_unmerged_feature_branches
    get_unmerged_branches 'feature/', 'develop'
  end

  private

  def get_unmerged_branches branch1, branch2
    branches = []
    get_repo_names.each do |repo_name|
      branch_names = get_branches(repo_name).select { |branch| branch.start_with? branch1 }
      branch_names.each do |branch_name|
        branch = get_branch_model_for_unmerged_branches(repo_name, branch_name, branch2)
        if branch.number_of_unmerged_commits > 0
          branches.push branch
        end
      end
    end
    branches
  end

  def get_merged_branches branch1, branch2
    branches = []
    get_repo_names.each do |repo_name|
      branch_names = get_branches(repo_name).select { |branch| branch.start_with? branch1 }
      branch_names.each do |branch_name|
        branch = get_branch_model_for_unmerged_branches(repo_name, branch_name, branch2)
        if branch.number_of_unmerged_commits == 0
          branch = get_branch_model_for_merged_branches(repo_name, branch_name)
          branches.push branch
        end
      end
    end
    branches
  end

  def get_branches repo_name
    repo_path = get_repo_path repo_name
    branch_names =`git --git-dir=#{repo_path} branch`
    branch_names.gsub("*", "").gsub(" ", "").split("\n")
  end

  def get_branch_model_for_unmerged_branches repo_name, branch1, branch2
    repo_path = get_repo_path repo_name
    git_output = `git --git-dir=#{repo_path} log #{branch1} ^#{branch2} --no-merges --pretty=format:"%h%x09%an%x09%ad%x09%s"`
    GitOutputParser.parse_brach_info branch1, repo_name, git_output
  end

  def get_branch_model_for_merged_branches repo_name, branch
    repo_path = get_repo_path repo_name
    git_output = `git --git-dir=#{repo_path} log #{branch} -n1 --no-merges --pretty=format:"%h%x09%an%x09%ad%x09%s"`
    GitOutputParser.parse_brach_info branch, repo_name, git_output
  end
end