$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "rspec"

require "domain/training_edition/training_edition"
require "domain/training_edition/training_edition_repository"

def training_repository
  TrainingRepository.instance
end

def training_edition_repository
  TrainingEditionRepository.instance
end

def reasonable_training_id
  3
end

describe "Training Edition persistence" do

  it "should return an instance of the saved object" do
    training = training_repository.find_by_id(db, 3)

    planned_date = Date.new 2012, 3, 4
    edition = TrainingEdition.plan_training_on_date training, planned_date
    saved_edition = training_edition_repository.save(db, edition)

    puts "Saved edition #{saved_edition}"
    saved_edition.class.should == TrainingEdition
  end

  it "should be able to save training editions" do
    # TODO factory girl?
    training = training_repository.find_by_id(db, 3)
    planned_date = Date.new 2012, 6, 12
    edition = TrainingEdition.plan_training_on_date training, planned_date


  end

  it "should assign an Id to a saved instance" do
    training = training_repository.find_by_id(db, 3)

    planned_date = Date.new 2012, 3, 4
    edition = TrainingEdition.plan_training_on_date training, planned_date
    saved_edition = training_edition_repository.save(db, edition)

    saved_edition.id.nil?.should == false
  end

  it "should allow retrieval of a saved instance" do
    training = training_repository.find_by_id(db, 3)

    planned_date = Date.new 2012, 3, 4
    edition = TrainingEdition.plan_training_on_date training, planned_date
    saved_edition = training_edition_repository.save(db, edition)

    retrieved_edition = training_edition_repository.find_by_id(db, saved_edition.id)

    retrieved_edition.nil?.should == false
  end

  it "should persist all the relevant information" do
    training_id = 13
    headline = "my headline"
    duration = 4
    date = Date.new 2012, 12, 20
    location = "somewhere"
    url = "www.avanscoperta.it"

    edition = TrainingEdition.new nil, training_id, headline, date, location, duration, url

    saved_edition = training_edition_repository.save(db, edition)

    retrieved_edition = training_edition_repository.find_by_id(db, saved_edition.id)

    retrieved_edition.training_id.should == training_id
    retrieved_edition.headline.should == headline
    retrieved_edition.duration.should == duration
    retrieved_edition.date.should == date
    retrieved_edition.location.should == location
    retrieved_edition.url.should == url

  end

  it "should allow to retrieve training editions by training id and date" do

    training = training_repository.find_by_id(db, reasonable_training_id)

    planned_date = Date.new 2012, 3, 4
    edition = TrainingEdition.plan_training_on_date training, planned_date
    training_edition_repository.save(db, edition)

    found_edition = training_edition_repository.find_by_headline_and_date(training.headline, planned_date)

    found_edition.nil?.should == false
    found_edition.training_id.should == reasonable_training_id
  end


end