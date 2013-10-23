require 'fileutils'

class FileUtil

	attr_reader :tmp_repos_path
	attr_reader :tmp_reports_path

	def setup_tmp_dir
		@tmp_path = '_gitflow-repo-report' + Time.now.to_i.to_s + rand(300).to_s.rjust(3, '0')
		@tmp_path = File.join('/tmp', @tmp_path)
		@tmp_repos_path = File.join(@tmp_path, 'repos')
		@tmp_reports_path = File.join(@tmp_path, 'reports')

		FileUtils.mkdir_p(@tmp_path)
		FileUtils.mkdir_p(@tmp_repos_path)
		FileUtils.mkdir_p(@tmp_reports_path)
		FileUtils.cp_r(Dir['tests/test_repos/*'], @tmp_repos_path)

		Dir.glob(Dir[File.join(@tmp_repos_path, '*')]) do |repo|
			FileUtils.mv(File.join(repo, '_git'), File.join(repo, '.git'))
		end
	end

	def remove_tmp_dir
		if @tmp_path
			FileUtils.rm_r(@tmp_path)
		end
	end

end