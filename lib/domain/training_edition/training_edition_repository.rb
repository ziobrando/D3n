require "singleton"
require "Sequel"
require "domain/training_edition/training_edition_factory"

class TrainingEditionRepository

  attr_accessor :data
  attr_accessor :training_edition_factory

  include Singleton

  def initialize
    @training_edition_factory = TrainingEditionFactory.new
  end

  # TODO OUCH! The name is non meaningful with the behavior!!
  def find_by_training_id_and_date training_id, date
    training_editions = db[:training_editions]
    found = training_editions.first(:training_id => training_id,
                                    :date => date)
    @training_edition_factory.create_from_map(found)
  end

  def find_by_headline_and_date headline, date
    training_editions = db[:training_editions]
    found = training_editions.first(:headline => headline,
                                    :date => date)
    @training_edition_factory.create_from_map(found)
  end

  # TODO I admit I used Cut & Paste here. That's a refactoring call'
  def save(db, training_edition)
    if training_edition.id.nil?
      insert db, training_edition
    else
      update db, training_edition
    end
  end

  def find_by_id(db, training_edition_id)
    trainings = db[:training_editions]
    found_map = trainings[:id => training_edition_id]
    puts found_map
    training_edition_factory.create_from_map found_map
  end

  private
  def update(db, training_edition)
    db[:training_editions].update(
        :training_id => training_edition.training_id,
        :headline => training_edition.headline,
        :location => training_edition.location,
        :date => training_edition.date,
        :duration => training_edition.duration,
        :url => training_edition.url
    )
    find_by_id db, training_edition.id
  end

  def insert(db, training_edition)
    id = db[:training_editions].insert(
        :training_id => training_edition.training_id,
        :headline => training_edition.headline,
        :location => training_edition.location,
        :date => training_edition.date,
        :duration => training_edition.duration,
        :url => training_edition.url
    )
    find_by_id db, id
  end
end