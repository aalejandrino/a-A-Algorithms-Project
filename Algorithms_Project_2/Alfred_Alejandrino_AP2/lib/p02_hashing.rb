class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index {|num,i| result += (num.hash*(i+1))}
    return result
  end
end

class String
  
  def hash
    alphabet = ("a".."z").to_a
    numbers = ('0'..'9').to_a
    result = 0

    self.downcase.chars.each_with_index do |char, i|
      if (alphabet.include?(char))
        result += alphabet.find_index(char).hash*(i+1)
      elsif (numbers.include?(char))
        result += char.to_i.hash*(i+1)
      end
    end

    return result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    alphabet = ("a".."z").to_a
    numbers = ('0'..'9').to_a

    keys = self.keys.sort.map {|k| k.to_s.downcase}
    values = self.values.sort.map {|k| k.to_s.downcase}
    result = 0
    
    (keys + values).each_with_index do |char, i|
      if (alphabet.include?(char))
        result += alphabet.find_index(char).hash*(i+1)
      elsif (numbers.include?(char))
        result += char.to_i.hash*(i+1)
      end
    end

    return result
  end
end
