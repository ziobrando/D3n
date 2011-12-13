require "Singleton"
require "Sequel"

class TrainingRepository

  attr_accessor :data
  attr_reader :training_factory

  include Singleton

  def initialize
    #@DB = Sequel.sqlite # spostare!
    #gem "mysql2"
    @DB = Sequel.mysql2('D3N', :user => 'root', :password => '')
    @training_factory = TrainingFactory.new
  end

  def trainings
    @DB[:trainings]
  end


  def save(training)
    if (training.id != nil)
      update training
    else
      insert training
    end
  end

  def find_by_id(training_id)
    found_map = trainings[:id => training_id]
    puts found_map
    training_factory.create_from_map found_map
  end

  def find_unique_by_name(training_name)
    found = trainings.first(:name => training_name)
    training_factory.create_from_map(found)
  end

  private
  def update(training)
    trainings.update(
        :name => training.name,
        :description => training.description,
        :url => training.url
    )
    find_by_id training.id
  end

  def insert training
    id = trainings.insert(
        :name => training.name,
        :description => training.description,
        :url => training.url
    )
    find_by_id id
  end


end