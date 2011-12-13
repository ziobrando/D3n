require 'domain/trainings/Publishing_service'

class Training

  attr_accessor :id
  attr_accessor :name
  attr_reader :description
  attr_reader :url
  attr_accessor :publishing_service

  def initialize (id, name, description, url)
    @id = id
    @name = name
    @description = description
    @url = url
    @publishing_service = nil
  end

  def to_s
    "Training: #{id} - #{name} - #{description}"
  end

  def publish publish_training_command
    outcome = @publishing_service.publish_on(self, publish_training_command.target_platform)
    @url = outcome.url
    training_repository.save(self) # spostare
    outcome
  end

  def is_available_on_catalog?
    !@url.nil?
  end
end
