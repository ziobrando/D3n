require 'events/Training_Published'

class PublishingService

  def publish_on training, target
    # pretend to do the job
    TrainingPublished.new training, "http://www.google.it"
  end
end