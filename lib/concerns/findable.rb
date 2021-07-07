module Concerns::Findable

  def find_by_name(name) #no need for 'self' before method name as it's implicit
    all.detect do |s|
      s.name == name
    end
  end

  def find_or_create_by_name(name) #no need for 'self' before method name as it's implicit
    find_by_name(name) || create(name)
  end

end
