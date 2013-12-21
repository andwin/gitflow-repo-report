require 'sinatra'

set :env,  :production
disable :run

require './gitflow_repo_report.rb'

run Sinatra::Application