require_relative 'models/report.rb'

class ReportRepository

	def self.latest
		report = Report.new

		report.date = Time.now

		report.repos.push('repo1')
		report.repos.push('repo2')
		report.repos.push('repo3')

		report.old_feature_branches.push('repo1 feature/ticket-1233')
		report.old_feature_branches.push('repo1 feature/ticket-4334')
		report.old_feature_branches.push('repo1 feature/ticket-5433')
		report.old_feature_branches.push('repo2 feature/ticket-7653')
		report.old_feature_branches.push('repo3 feature/ticket-5456')

		report.unmerged_release_branches.push('repo1 release/ticket-1233')
		report.unmerged_release_branches.push('repo2 release/ticket-1453')
		report.unmerged_release_branches.push('repo2 release/ticket-233')
		report.unmerged_release_branches.push('repo4 release/ticket-1233')
		report.unmerged_release_branches.push('repo5 release/ticket-1454')

		report.repos_with_unmerged_master_branch.push('repo2 master')

		report
	end

	def self.list
		list = ['2013-09-23 23:13:23',
				'2013-09-22 22:12:56',
				'2013-09-21 21:16:23',
				'2013-09-20 22:12:45',
				'2013-09-19 21:11:23',
				'2013-09-18 23:16:13',
				'2013-09-17 22:16:15']
	end

	def self.load(name)

		report = Report.new

		report.date = Time.now

		report.repos.push('repo1')
		report.repos.push('repo2')

		report.old_feature_branches.push('repo2 feature/ticket-7653')
		report.old_feature_branches.push('repo3 feature/ticket-5456')

		report.unmerged_release_branches.push('repo1 release/ticket-1233')
		report.unmerged_release_branches.push('repo2 release/ticket-1453')

		report
	end
end