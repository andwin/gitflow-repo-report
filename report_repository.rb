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
			list.push item
		end

		list.sort.reverse
	end

	def self.load(name)
		YAML.load(File.read(name))
	end
end