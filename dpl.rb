require 'rubygems'
require 'dpl/cli'
require 'json'

input = begin 
          JSON.parse(STDIN.read)
        rescue Exception => e
          puts e if ENV['DEBUG']
          exit 1
        end

vargs = input['vargs']

if vargs.nil? || vargs.empty?
  puts "ERROR: no vargs given, check your .drone.yml"
  exit 1
end

deployments = vargs['deployments']

if deployments.nil?
  puts "ERROR: no dpeloyments given, check your .drone.yml"
  exit 1
elsif not deployments.is_a?(Array)
  puts "ERROR: array expected, but got: #{deployments.class.to_s.downcase}"
  exit 1
end

clis = deployments.map do |deploy|
  unless deploy.is_a?(Hash)
    puts "WARN: skipped, hash expected, but got: #{deployment.class.to_s.downcase} with: #{deploy.inspect}"
    
  end

  args = deploy.inject([]) do |arr, (key, value)|
    if value.is_a?(TrueClass) || value.is_a?(FalseClass)
      arr << "--#{key}" if value
    else
      arr << "--#{key}==#{value}"
    end
  end

  DPL::CLI.new(args)
end

clis.reject(&:nil?).each(&:run)
