$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "rspec"

require "domain/trainings/training_factory"
require "domain/trainings/training_repository"

def db
  Configuration.new.db
end

def training_repository
  TrainingRepository.new db
end

describe "Saving a training" do

  it "should return an instance of the saved object" do
    training = TrainingFactory.new.create_new("T-Name", "T-desc")
    saved_training = training_repository.save(training)

    puts "Saved training #{saved_training}"
    saved_training.class.should == Training
  end

  it "should contain an id" do
    training = TrainingFactory.new.create_new("T-name 2", "T desc 2")
    saved_training = training_repository.save(training)

    saved_training.id.class.should == Fixnum
  end

  it "should persist a training" do
    training = TrainingFactory.new.create_new("T-Name", "T-desc")
    saved_training = training_repository.save(training)

    found = training_repository.find_by_id(saved_training.id)
    found.should_not == nil
    found.name.should == training.name
  end

  it "should add an ID on insert" do
    training = TrainingFactory.new.create_new("T-Name", "T-desc")
    saved_training = training_repository.save(training)

    saved_training.id.nil?.should == false
  end


end

describe "Finding a training by id" do

  it "should return an instance of training" do
    found = training_repository.find_by_id(1)
    found.class.should == Training
  end

  it "should contain all the relevant information" do
    found = training_repository.find_by_id(1)
    found.name.should_not == nil
    found.description.should_not == nil
  end



end