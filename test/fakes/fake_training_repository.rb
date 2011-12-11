$:.unshift File.join(File.dirname(__FILE__), "../..", "lib")

require "domain/trainings/training"
require 'Singleton'

class FakeTrainingRepository

  attr_accessor :data
  include Singleton

  def initialize
    @storage = []
    @id = 1

  end

  def generate_id
    @id = @id+1
  end

  def find_by_id(training_id)
    if (training_id == nil)
      nil
    else
      @storage[training_id]
    end
  end

  def save(training)
    if (training.id == nil)
      training.id = generate_id
    end
    @storage[training.id] = training
  end

  def find_by_name(training_name)
    found = nil
    @storage.entries { |t| if (t.name == training_name)
      found = t
                           end }
    found
  end

end