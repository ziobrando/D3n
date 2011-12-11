require "rubygems"
require "sequel"

#DB = Sequel.sqlite
#gem('mysql2')
DB = Sequel.mysql2('D3N', :user => 'root', :password => '')

puts "connected to " + DB.to_s

DB.drop_table("trainings")

DB.create_table("trainings") do
  primary_key :id
  String :name
  String :description
end
puts "table trainings created?"
trainings = DB[:trainings]
puts "Entry in table: #{trainings.count}"