
class Training

  attr_accessor :id
  attr_accessor :headline
  attr_reader :description
  attr_reader :duration
  attr_reader :url
  attr_accessor :publishing_service

  def initialize (id, headline, description, duration, url)
    @id = id
    @headline = headline
    @description = description
    @duration = duration
    @url = url
    @publishing_service = nil
  end

  def to_s
    "Training: #{id} - #{headline} - #{description}"
  end

  def publish(command)
    outcome = @publishing_service.publish_on(self, command.target_platform)
    @url = outcome.url
    outcome
  end

  def is_available_on_catalog?
    !@url.nil?
  end
end
