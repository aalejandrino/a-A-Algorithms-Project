def well_formed_string(str)

    open_brackets = ["{", "[", "("]
    closed_brackets = ["}", "]", ")"]

    str.split('').each do |char|
        if char == "{"

    end
end




def well_formed(str)

    left_chars = []
    lookup = {'(' => ')', '[' => ']', '{' => '}'}

    str.chars.each do |char|
        if lookup.keys.include?(char)
            left_chars << char
        elsif left_chars.length == 0 || lookup[left_chars.pop] != char
            return false
        end
    end

    return left_chars.empty?

end