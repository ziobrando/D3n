require "singleton"
require "Sequel"

class TrainingRepository

  attr_reader :training_factory
  attr_accessor :data

  include Singleton

  def initialize
    @training_factory = TrainingFactory.new
  end

  def save(db, training)
    if training.id.nil?
      insert db, training
    else
      update db, training
    end
  end

  def find_by_id(db, training_id)
    trainings = db[:trainings]
    found_map = trainings[:id => training_id]
    puts found_map
    training_factory.create_from_map found_map
  end

  def find_unique_by_headline(db, headline)
    trainings = db[:trainings]
    found = trainings.first(:headline => headline)
    training_factory.create_from_map(found)
  end

  private
  def update(db, training)
    db[:trainings].update(
        :headline => training.headline,
        :description => training.description,
        :duration => training.duration,
        :url => training.url
    )
    find_by_id db, training.id
  end

  def insert(db, training)
    id = db[:trainings].insert(
        :headline => training.headline,
        :description => training.description,
        :duration => training.duration,
        :url => training.url
    )
    find_by_id db, id
  end


end