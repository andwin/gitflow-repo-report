require 'fileutils'

class FileUtil

	def setup_tmp_repo_dir
		@tmp_repo_path = '_gitflow-repo-report' + Time.now.to_i.to_s + rand(300).to_s.rjust(3, '0')

		@tmp_repo_path = File.join("/tmp/", @tmp_repo_path)

		FileUtils.mkdir_p(@tmp_repo_path)
		pwd = Dir.pwd

		Dir.chdir @tmp_repo_path

		`git clone --bare git@github.com:andwin/gitflow-repo-report-test-repo-1.git test-repo-1`
		`git clone --bare git@github.com:andwin/gitflow-repo-report-test-repo-2.git test-repo-2`

		Dir.chdir pwd

		@tmp_repo_path
	end

	def remove_tmp_repo_dir
		if @tmp_repo_path
			FileUtils.rm_r(@tmp_repo_path)
		end
	end

end