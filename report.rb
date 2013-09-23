require 'sinatra'
require_relative 'models/report.rb'

set :erb, :layout => :'layouts/default'

get '/' do

	@report = Report.new

	@repost.repos.push('repo1')
	@repost.repos.push('repo2')
	@repost.repos.push('repo3')

	@report.test = 'hej'

	erb :index
end

get '/list/' do
	erb :list
end

get '/generate/' do
	erb 'generating new repot...'
end