require "Singleton"
require "Sequel"

class TrainingRepository

  attr_reader :training_factory
  attr_accessor :data

  include Singleton

  def initialize
    @training_factory = TrainingFactory.new
  end

  def save(db, training)
    if (training.id != nil)
      update db, training
    else
      insert db, training
    end
  end

  def find_by_id(db, training_id)
    trainings = db[:trainings]
    found_map = trainings[:id => training_id]
    puts found_map
    training_factory.create_from_map found_map
  end

  def find_unique_by_name(db, training_name)
    trainings = db[:trainings]
    found = trainings.first(:name => training_name)
    training_factory.create_from_map(found)
  end

  private
  def update(db, training)
    db[:trainings].update(
        :name => training.name,
        :description => training.description,
        :url => training.url
    )
    find_by_id db, training.id
  end

  def insert db, training
    id = db[:trainings].insert(
        :name => training.name,
        :description => training.description,
        :url => training.url
    )
    find_by_id db, id
  end


end