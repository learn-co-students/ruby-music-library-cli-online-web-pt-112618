module Concerns::Findable
  def self.find_by_name(name)
    self.all.detect do |song|
      song.name == name
    end
  end 
  
  def find_or_create_by_name(name)
    # if self.find_by_name(name)
    #   self.find_by_name(name)
    # else
    # song = self.create(name)
    # end

    find_by_name(name) || create(name)
      

  end
end