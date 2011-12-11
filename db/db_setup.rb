require "sequel"

class DBSetup



  def create_tables
    DB.create_table :trainings do
      primary_key :id
      String :name
      String :description
    end
  end

end