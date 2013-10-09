require 'yaml'
require_relative 'models/report.rb'

class ReportRepository

	def self.latest
		load list.first
	end

	def self.list
		list = Array.new

		Dir.glob('reports/*.yaml') do |item|
			next if item == '.' or item == '..'
			list.push item.sub('.yaml', '').sub('reports/', '')
		end

		list.sort.reverse
	end

	def self.load(name)
		YAML.load(File.read('reports/' + name + '.yaml'))
	end
end