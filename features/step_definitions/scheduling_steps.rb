require 'commands/plan_training_edition'
require 'domain/training_edition/training_edition_repository'

def application_facade
  ApplicationFacade.instance
end

def db
  Configuration.new.db
end

def training_edition_repository
  TrainingEditionRepository.instance
end

When /^a planned delivery date (.*)$/ do |planned_delivery_date|
  @delivery_date = Date.parse planned_delivery_date
end

When /^a selected Location for the class (.*)$/ do |selected_location|
  @selected_location = selected_location # TODO Ok, for now but insufficient
end

When /^I plan an Edition of Training (.*)$/ do |training_name|
  training = training_repository.find_unique_by_headline db, training_name
  command = PlanTrainingEdition.new(
      training.id,
      training_name,
      @selected_location,
      @delivery_date,
      training.duration
  )
  application_facade.plan_training_edition command
  command.training_id.should == training.id
  command.duration.should == training.duration
  command.selected_location.should == @selected_location
  command.selected_date.should == @delivery_date
end

Then /^an Edition of Training (.*) should be planned for date (.*)$/ do |headline, planned_delivery_date|
  lookup_date = Date.parse planned_delivery_date
  found_edition = training_edition_repository.find_by_headline_and_date(headline, lookup_date)
  found_edition.should_not == nil
  found_edition.class.should == TrainingEdition
end