$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")
$:.unshift File.join(File.dirname(__FILE__), "../..", "test")

require 'domain/trainings/Training_Factory'
require 'application/Application_Facade'
require 'commands/Create_Training'
require 'commands/Publish_Training'


module MockPublisher
  def publisher_service
     MockPublisherService.new
  end
end

class MockPublisherService
  def initialize

  end

  def pubblica(corso, target)

  end
end

def application_facade
  ApplicationFacade.instance
end

def training_factory
  TrainingFactory.new
end

def db
  Configuration.new.db
end

def training_repository
  TrainingRepository.instance
end


Given /^a Catalog$/ do
  # Do I really need a Catalog?
end

When /^a Training (.*) not yet published$/ do |training_name|
  training_data = CreateTraining.new(training_name, "generic description")
  @created_training = application_facade.create_training(training_data)
  puts "Created training #{@created_training}"
end

When /^I publish Training (.*) on Catalog$/ do |training_name|
  training = training_repository.find_unique_by_name db, training_name
  publish_command = PublishTraining.new(training.id, "Target")

  application_facade.publish_training(publish_command)
end

Then /^Training (.*) is available on Catalog$/ do |training_name|
  training = training_repository.find_unique_by_name db, training_name
  training.is_available_on_catalog?.should == true
end

Given /^a Training name (.*)$/ do |training_name|
  @inserted_training_name = training_name
end

When /^a Training Description like "([^"]*)"$/ do |training_description|
  @inserted_description = training_description
end

When /^a user tells to create a Training with the given Name and Description$/ do
  create_training_command = CreateTraining.new(@inserted_training_name, @inserted_description)
  @created_training = application_facade.create_training(create_training_command)
  puts "Created training: #{@created_training}"
end

Then /^a Training named (.*) is available$/ do |training_name|
  found = training_repository.find_unique_by_name(db, training_name)
  found.should_not == nil
  found.class.should == Training
  puts "Found: #{found}"
end

Then /^the Training (.*) is given an Id$/ do |generic_training|
  @created_training.id.should_not == nil
end

When /^the Training named (.*) can be retrieved via Id$/ do |training_name|
  found_training_via_id = training_repository.find_by_id(db, @created_training.id)
  found_training_via_id.should_not == nil
  found_training_via_id.class.should == Training
  found_training_via_id.name.should == training_name
end