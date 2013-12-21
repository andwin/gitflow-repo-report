class TestUtils

  attr_reader :tmp_repos_path
  attr_reader :tmp_reports_path

  def initialize
    @tmp_repos_path = 'spec/tmp/repos'
    @tmp_reports_path = 'spec/tmp/reports'
  end

  def setup_tmp_dir
    cleanup_tmp_dir

    FileUtils.cp_r(Dir['spec/test_repos/*'], @tmp_repos_path)

    Dir.glob(Dir[File.join(@tmp_repos_path, '*')]) do |repo|
      FileUtils.mv(File.join(repo, '_git'), File.join(repo, '.git'))
    end
  end

  def cleanup_tmp_dir
    FileUtils.rm_rf Dir.glob("#{@tmp_repos_path}/*")
    FileUtils.rm_rf Dir.glob("#{@tmp_reports_path}/*")
  end
end