$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "rspec"
require "domain/trainings/training_factory"
require "commands/publish_training"

describe "Publish to an external service" do

  it "should return a training published event" do
    training_name = "My training"
    training = TrainingFactory.new().create_new(training_name,"description")
    command = PublishTraining.new "",""
    outcome = training.publish command

    outcome.should_not == nil
    outcome.class.should == TrainingPublished
  end

  it "should contain training information" do
    training_name = "My training"
    training = TrainingFactory.new().create_new(training_name,"description")

    outcome = training.publish PublishTraining.new("Training", "Target")

    outcome.training.name.should == training_name
  end

  it "should contain a timestamp"  do
    training_name = "My training"
    training = TrainingFactory.new().create_new(training_name,"description")

    outcome = training.publish PublishTraining.new("Training", "Target")

    outcome.timestamp.nil?.should == false
  end


end