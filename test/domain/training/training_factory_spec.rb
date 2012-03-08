require "rspec"
require "domain/trainings/Training_factory"

def training_factory
  TrainingFactory.new
end

describe "creating a training" do

  it "should create a consistent training from scratch" do
    training = training_factory.create_new("headline", "description", 3)

    training.headline.should == "headline"
    training.description.should == "description"
  end

  it "should not have an id" do
    training = training_factory.create_new("nome", "description", 5)

    training.id.nil?.should == true
  end
end