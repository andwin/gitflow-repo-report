Dir.chdir(File.dirname(__FILE__)) do
  Dir.glob('**/test_*.rb') do |test_case| 
  	puts File.expand_path(File.dirname(File.dirname(__FILE__)))
    require "#{File.expand_path(File.dirname(File.dirname(__FILE__)))}/#{test_case}" 
  end
end