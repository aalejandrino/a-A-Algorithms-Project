require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
    # hsh = Hash.new(0)
    hsh = HashMap.new
    string.chars.each do |ch|
        if hsh[ch]
            hsh[ch] += 1
        else
            hsh[ch] = 1
        end
    end

    count = 0

    hsh.each do |k, v|
        count += 1 if hsh[k] % 2 == 1
        return false if count > 1
    end

    return true
end
