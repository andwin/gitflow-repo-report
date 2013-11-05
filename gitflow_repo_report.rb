require 'sinatra'
require 'sinatra/config_file'
require_relative 'models/report.rb'
require_relative 'report_repository.rb'
require_relative 'report_generator.rb'

config_file 'config.yml'
set :erb, :layout => :'layouts/default'

reports_repository = ReportRepository.new settings.reports_path

get '/' do
  @report = reports_repository.latest
  return erb 'No reports found! <a href="/generate/">Click here to generate</a>' if @report == nil

  erb :report
end

get '/list/?' do
  @list = reports_repository.list
  erb :list
end

get '/view/:name/?' do
  @report = reports_repository.load(params[:name])
  erb :report
end

get '/generate/?' do
  report_generator = ReportGenerator.new settings.repos_path
  report_generator.generate_report settings.reports_path
  erb 'The report is generated! <a href="/">Click here to view</a>'
end