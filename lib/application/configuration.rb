
class Configuration
  attr_accessor :db

  def initialize
    @db = Sequel.mysql2('D3N', :user => 'root', :password => '')
  end

end