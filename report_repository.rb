require 'yaml'
require_relative 'models/report.rb'

class ReportRepository
	def self.latest
		load list.first
	end

	def self.list
		list = []
		Dir.glob('reports/*.yaml') do |item|
			next if item == '.' or item == '..'
			list.push File.basename(item, '.yaml')  
		end
		list.sort.reverse
	end

	def self.load(name)
		YAML.load(File.read(File.join('reports', name + '.yaml')))
	end
end