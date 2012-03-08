class CreateTraining

  attr_accessor :name
  attr_accessor :description
  attr_accessor :duration

  def initialize name, description, duration
    @name = name
    @description = description
    @duration = duration
  end

  def to_s
    "CreateTraining: name: #{@name}, description: #{@description}"
  end
end