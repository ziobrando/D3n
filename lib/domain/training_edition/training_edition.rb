class TrainingEdition

  attr_accessor :id
  attr_reader :training_id
  attr_reader :headline
  attr_reader :date
  attr_reader :duration
  attr_reader :url
  attr_reader :location

  def initialize  id, training_id, headline, date, location, duration, url
    @id = id
    @training_id = training_id
    @headline = headline
    @date = date
    @location = location
    @duration = duration
    @url = url
  end

  def TrainingEdition.plan_training_on_date training, date
    location = "unspecified"
    TrainingEdition.new(
        nil,
        training.id,
        training.headline,
        date,
        location,
        training.duration,
        nil
    )
  end

end