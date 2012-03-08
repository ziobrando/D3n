$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "rspec"

require "domain/trainings/training_factory"
require "domain/trainings/training_repository"

def db
  Configuration.new.db
end

def training_repository
  TrainingRepository.instance
end

describe "Saving a training" do

  it "should return an instance of the saved object" do
    training = TrainingFactory.new.create_new("T-Name", "T-desc", 3)
    saved_training = training_repository.save(db, training)

    puts "Saved training #{saved_training}"
    saved_training.class.should == Training
  end

  it "should contain an id" do
    training = TrainingFactory.new.create_new("T-name 2", "T desc 2", 3)
    saved_training = training_repository.save(db, training)

    saved_training.id.class.should == Fixnum
  end

  it "should persist all the relevant training data" do
    headline = "Test class headline"
    description = "test class description"

    training = TrainingFactory.new.create_new(headline, description, 3)

    saved_training = training_repository.save(db, training)

    found = training_repository.find_by_id(db, saved_training.id)
    found.should_not == nil
    found.headline.should == headline
    found.description.should == description
  end

  it "should add an ID on insert" do
    training = TrainingFactory.new.create_new("T-Name", "T-desc", 3)
    saved_training = training_repository.save(db, training)

    saved_training.id.nil?.should == false
  end


end

describe "Finding a training by id" do

  good_training_id = 2

  it "should return an instance of training" do
    found = training_repository.find_by_id(db, good_training_id)
    found.class.should == Training
  end

  it "should contain all the relevant information" do
    found = training_repository.find_by_id(db, good_training_id)
    found.headline.should_not == nil
    found.description.should_not == nil
  end

end