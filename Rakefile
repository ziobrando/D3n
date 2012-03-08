require 'rubygems'
require 'sequel'
require 'cucumber'
require 'cucumber/rake/task'
require 'mysql2'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :default => :test

task :db_init do
  #@db = Sequel.mysql2('D3N', :user => 'root', :password => '')
  @db = Sequel.sqlite('D3N', :user => 'root', :password => '')
  puts "rakefile connected to " + @db.to_s
end

task :db_setup => [:db_init] do

  Rake::Task["db_training_content_setup"].invoke
  Rake::Task["db_training_edition_setup"].invoke

  # todo remove duplication
end

task :db_training_content_setup => [:db_init] do
  if @db.table_exists?(:trainings)
    puts "Dropping old training table"
    @db.drop_table(:trainings)
    puts "Table trainings dropped"
  end

  @db.create_table(:Trainings) do
    primary_key :id
    string :headline
    string :description
    integer :duration
    string :url
  end
  puts "table trainings created?"
  trainings = @db[:trainings]
  puts "entry in table: #{trainings.count}"
end

task :db_training_edition_setup => [:db_init] do
  if @db.table_exists?(:training_editions)
    puts "dropping old training editions table"
    @db.drop_table(:training_editions)
  end

  puts "now creating table training editions"
  @db.create_table(:training_editions) do
    primary_key :id
    string :location
    integer :training_id
    string :headline
    date :date
    integer :duration
    string :url
  end

  puts "table training editions created."
  training_editions = @db[:training_editions]
  puts "entry in table: #{training_editions.count}"

end

task :test_data_setup => [:db_init] do
  sample_training = [ :headline => "sample training", :description => "sample class", :duration => 2, :url => nil ]

  @db[:trainings].insert(
      :headline => sample_training.headline,
      :description => sample_training.description,
      :duration => sample_training.duration,
      :url => sample_training.url
  )
end

task :test do
  require file.dirname(__file__) + '/test/all_tests.rb'
end

