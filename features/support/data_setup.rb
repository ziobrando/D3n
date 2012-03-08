require "rubygems"
require "sequel"

#DB = Sequel.sqlite
#gem('mysql2')
DB = Sequel.mysql2('D3N', :user => 'root', :password => '')

puts "connected to " + DB.to_s

if DB.table_exists? :trainings
  DB.drop_table("trainings")
end

DB.create_table("trainings") do
  primary_key :id
  String :headline
  String :description
  Integer :duration
  String :url
end
puts "table trainings created?"
trainings = DB[:trainings]
puts "Entry in table: #{trainings.count}"


if DB.table_exists? :training_editions
  DB.drop_table(:training_editions)
end

DB.create_table(:training_editions) do
  primary_key :id
  Integer :training_id
  String :headline
  String :location
  Date :date
  Integer :duration
  String :url
end
puts "table training editions created?"
training_editions = DB[:training_editions]
puts "Entry in table: #{training_editions.count}"
