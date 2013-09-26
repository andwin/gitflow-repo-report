require 'test/unit'
require 'fileutils'

class Test::Unit::TestCase

	def setup_tmp_repo_dir
		@tmp_repo_path = '_gitflow-repo-report' + Time.now.to_i.to_s + rand(300).to_s.rjust(3, '0')

		@tmp_repo_path = File.join("/tmp/", @tmp_repo_path)

		FileUtils.mkdir_p(@tmp_repo_path)
		FileUtils.cp_r('tests/test_repos', @tmp_repo_path)

		Dir.glob(File.join(@tmp_repo_path, 'test_repos/*')) do |repo|
			FileUtils.mv(File.join(repo, '_git'), File.join(repo, '.git'))
		end

		@tmp_repo_path
	end

	def remove_tmp_repo_dir
		if @tmp_repo_path
			FileUtils.rm_r(@tmp_repo_path)
		end
	end

end