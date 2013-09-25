require 'sinatra'
require 'grit'
require_relative 'models/report.rb'
require_relative 'report-repository.rb'

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
	erb 'generating new report...'
end