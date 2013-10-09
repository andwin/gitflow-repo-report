require 'sinatra'
require_relative 'models/report.rb'
require_relative 'report_repository.rb'
require_relative 'report_generator.rb'

set :erb, :layout => :'layouts/default'

get '/' do
	@report = ReportRepository.latest
	erb :report
end

get '/list/?' do
	@list = ReportRepository.list
	erb :list
end

get '/view/:name/?' do
	@report = ReportRepository.load(params[:name])
	erb :report
end

get '/generate/?' do
	report_generator = ReportGenerator.new 'repos'
	report_generator.generate_report 'reports'
	erb 'report generates'
end