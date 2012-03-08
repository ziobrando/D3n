$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "rspec"

require 'commands/plan_training_edition'

def valid_training_id
  1
end

def factory
  TrainingEditionFactory.new
end

describe "Creation from plan command" do

  it "should create a valid instance of training edition" do
    location = "somewhere"
    planned_date = Date.new 2012, 5, 15
    duration = 3
    headline = "The fantastic Magoo class"
    command = PlanTrainingEdition.new valid_training_id, headline, location, planned_date, duration

    edition = factory.plan_training_edition(command)

    edition.date.should == planned_date
    edition.headline.should == headline
    edition.duration.should == duration
    edition.location.should == location
  end
end