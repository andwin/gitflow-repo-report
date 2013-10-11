require 'sinatra'
require_relative 'models/report.rb'
require_relative 'report_repository.rb'
require_relative 'report_generator.rb'

set :erb, :layout => :'layouts/default'

get '/' do
	@report = ReportRepository.latest
	return erb 'No reports found! <a href="/generate/">Click here to generate</a>' if @report == nil

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
	erb 'report generated! <br /> <a href="/">Click here to view</a>'
end