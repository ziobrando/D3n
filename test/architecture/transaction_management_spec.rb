require "rspec"
require "application/Application_Facade"
require "commands/Create_Training"

class ExplodingRepository
  def initialize db
    @real_repository = TrainingRepository.new db
  end

  def save training
    @real_repository.save training
    raise Sequel::Rollback
  end

end

describe "transaction management" do

  it "should rollback on Repository exception" do
    unwanted_name = "This class should not be published"

    class ApplicationFacade
      def training_repository
        ExplodingRepository.new db
      end
    end
    facade = ApplicationFacade.instance
    command = CreateTraining.new unwanted_name,"description"

    facade.create_training command

    found = training_repository.find_unique_by_name(unwanted_name)

    found.nil?.should == true
  end
end

