class PublishTraining

  attr_reader :training_id
  attr_reader :target_platform

  def initialize training_id, target_platform
    @training_id = training_id
    @target_platform = target_platform
  end
end