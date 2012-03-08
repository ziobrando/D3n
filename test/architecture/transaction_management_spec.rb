require "rspec"
require "application/Application_Facade"
require "commands/Create_Training"

class ExplodingRepository
  def initialize
    @real_repository = TrainingRepository.instance
  end

  def save db, training
    @real_repository.save db, training
    raise Sequel::Rollback
  end

end

describe "transaction management" do

  it "should rollback on Repository exception" do
    unwanted_name = "This class should not be published"

    class ApplicationFacade
      def training_repository
        ExplodingRepository.new
      end
    end
    facade = ApplicationFacade.instance
    command = CreateTraining.new unwanted_name, "description", 4

    facade.create_training command

    found = training_repository.find_unique_by_headline(db, unwanted_name)

    found.nil?.should == true
  end
end

