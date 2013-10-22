require 'yaml'
require 'sinatra/config_file'
require_relative 'models/report.rb'

class ReportRepository
	def initialize reports_path
		@reports_path = reports_path
	end

	def latest
		load list.first
	end

	def list
		list = []
		Dir.glob(File.join(@reports_path, '*.yaml')) do |item|
			next if item == '.' or item == '..'
			list.push File.basename(item, '.yaml')  
		end
		list.sort.reverse
	end

	def load(name)
		return nil if name == nil

		YAML.load(File.read(File.join(@reports_path, name + '.yaml')))
	end
end