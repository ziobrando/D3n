class CreateTraining

  attr_accessor :name
  attr_accessor :description

  def initialize name, description
    @name = name
    @description = description
  end

  def to_s
    "CreateTraining: name: #{@name}, description: #{@description}"
  end
end