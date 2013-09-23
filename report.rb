require 'sinatra'
require_relative 'models/report.rb'

set :erb, :layout => :'layouts/default'

get '/' do
	@report = Report.new

	@report.repos.push('repo1')
	@report.repos.push('repo2')
	@report.repos.push('repo3')

	erb :index
end

get '/list/' do
	erb :list
end

get '/generate/' do
	erb 'generating new repot...'
end