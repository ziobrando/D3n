class TrainingPublished

  attr_reader :timestamp
  attr_reader :training
  attr_reader :url

  def initialize training, url
    @timestamp = DateTime.new
    @training = training
    @url = url
  end
end