require 'domain/trainings/Training'
require 'domain/trainings/publishing_service'

class TrainingFactory
  def initialize
    @publishing_service = PublishingService.new
  end

  def publishing_service
    @publishing_service
  end

  def create_new_from_command(create_training)
    puts "Received command: #{create_training}"
    training = Training.new(
        nil,
        create_training.name,
        create_training.description,
        create_training.duration,
        nil)
    inject_stuff(training)
    training
  end

  def create_from_map(map)
    if map.nil?
      nil
    else

      training = Training.new(
          map[:id],
          map[:headline],
          map[:description],
          map[:duration],
          map[:url]
      )
      inject_stuff(training)
      training
    end
  end

  def create_new(headline, description, duration)
    training = Training.new(nil, headline, description, duration, nil)
    inject_stuff(training)
    training
  end

  private
  def inject_stuff (training)
    training.publishing_service = publishing_service
  end


end
