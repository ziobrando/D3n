require "rubygems"
require "sequel"

task :default => :test

task :db_setup do
  DB = Sequel.sqlite
  # Create Trainings
  puts "connected to " + DB.to_s
  DB.create_table("trainings") do
    primary_key :id
    String :name
    String :description
  end
  puts "table trainings created?"
  trainings = DB[:trainings]
  puts "Entry in table: #{trainings.count}"
end

task :test do
  require File.dirname(__FILE__) + '/test/all_tests.rb'
end