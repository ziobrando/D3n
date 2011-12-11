$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "domain/trainings/training_repository"

class ApplicationFacade

  def training_repository
    TrainingRepository.instance
  end

  def create_training(create_training_command)
    training = training_factory.create_new_from_command(create_training_command)
    puts "Now storing the training: #{training}"
    training_repository.save(training)
  end

  def publish_training(publish_training_command)
    training = training_repository.find_by_id(publish_training_command.training_id)
    puts "Training: " + training.to_s
    training.publish(publish_training_command)
    # TODO intercept returned event
  end


end