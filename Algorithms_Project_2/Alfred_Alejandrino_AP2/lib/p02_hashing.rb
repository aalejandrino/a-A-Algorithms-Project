class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index {|num,i| result += (num*(i+1))}
    return result
  end
end

class String
  
  def hash
    characters = ("a".."z").to_a + ('0'..'9').to_a
    result = 0

    self.downcase.chars.each_with_index do |char, i|
      result += characters.find_index(char)*(i+1)
    end

    return result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    characters = ("a".."z").to_a + ('0'..'9').to_a
    keys = self.keys.sort.map {|k| k.to_s.downcase}
    values = self.values.sort.map {|k| k.to_s.downcase}
    result = 0
    
    (keys + values).each_with_index do |char, i|
      result += characters.find_index(char)*(i+1)
    end

    return result
  end
end
