class PlanTrainingEdition

  attr_reader :training_id
  attr_reader :headline
  attr_reader :selected_location
  attr_reader :selected_date
  attr_reader :duration


  def initialize(training_id, headline, selected_location, selected_date, duration)
    @training_id = training_id
    @headline = headline
    @selected_location = selected_location
    @selected_date = selected_date
    @duration = duration
  end
end