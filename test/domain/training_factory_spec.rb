require "rspec"
require "domain/trainings/Training_factory"

def training_factory
  TrainingFactory.new
end

describe "creating a training" do

  it "should create a consistent training from scratch" do
    training = training_factory.create_new("nome", "descrizione")

    training.name.should == "nome"
    training.description.should == "descrizione"
  end

  it "should not have an id" do
    training = training_factory.create_new("nome", "descrizione")

    training.id.nil?.should == true
  end
end