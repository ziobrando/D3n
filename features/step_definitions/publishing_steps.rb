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
  # TODO Do I really need a Catalog?
end

When /^a Training (.*) not yet published$/ do |training_name|
  training_data = CreateTraining.new(training_name, "generic description", 2)
  @created_training = application_facade.create_training(training_data)
  @created_training.id.nil?.should == false
  @created_training.is_available_on_catalog?.should == false
  puts "Created training #{@created_training}"
end

When /^I publish Training (.*) on Catalog$/ do |headline|
  training = training_repository.find_unique_by_headline db, headline
  publish_command = PublishTraining.new(training.id, "Target")

  application_facade.publish_training(publish_command)
end

Then /^Training (.*) is available on Catalog$/ do |headline|
  training = training_repository.find_unique_by_headline db, headline
  training.is_available_on_catalog?.should
end

Given /^a Training name (.*)$/ do |training_name|
  @inserted_training_name = training_name
end

When /^a Training Description like "([^"]*)"$/ do |training_description|
  @inserted_description = training_description
end

When /^a user tells to create a Training with the given Name, Description and Duration$/ do
  create_training_command = CreateTraining.new(@inserted_training_name, @inserted_description, @inserted_duration)
  @created_training = application_facade.create_training(create_training_command)
  puts "Created training: #{@created_training}"
end

Then /^a Training named (.*) is available$/ do |headline|
  found = training_repository.find_unique_by_headline(db, headline)
  found.should_not == nil
  found.class.should == Training
  puts "Found: #{found}"
end

Then /^the Training (.*) is given an Id$/ do |generic_training|
  @created_training.id.should_not == nil
end

When /^the Training named (.*) can be retrieved via Id$/ do |headline|
  found_training_via_id = training_repository.find_by_id(db, @created_training.id)
  found_training_via_id.should_not == nil
  found_training_via_id.class.should == Training
  found_training_via_id.headline.should == headline
end

# This one is not really clearly defined yet.
# Looks like an expansion point. ;-)
Given /^an existing Training called (.*)$/ do |training_name|
  step "a Training #{training_name} not yet published"
  #pending
end