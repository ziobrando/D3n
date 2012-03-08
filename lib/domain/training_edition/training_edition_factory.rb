require 'domain/training_edition/training_edition'

class TrainingEditionFactory
  # To change this template use File | Settings | File Templates.

  def create_from_map(map)
    if map.nil?
      nil
    else

      training_edition = TrainingEdition.new(
          map[:id],
          map[:training_id],
          map[:headline],
          map[:date],
          map[:location],
          map[:duration],
          map[:url]
      )
      inject_stuff(training_edition)
      training_edition
    end
  end

  def plan_training_edition(command)
    TrainingEdition.new(
        nil,
        command.training_id,
        command.headline,
        command.selected_date,
        command.selected_location,
        command.duration,
        nil
    )

  end

  private
  def inject_stuff training_edition
    #training.publishing_service = publishing_service
  end

end