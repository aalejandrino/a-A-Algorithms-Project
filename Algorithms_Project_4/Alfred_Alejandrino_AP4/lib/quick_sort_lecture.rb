class QuickSort

    def self.sort1(array)
        return array if array.length <= 1

        pivot_idx = rand(array.length)
        pivot_val = array[pivot_idx]
        left = []
        right = []

        array.each do |el, curr_idx|
            next if curr_idx == pivot_idx
            if el < pivot_val
                left << el
            else
                right << el
            end
        end

        sort1(left) + [pivot_val] + sort1(right)
    end

    def self.swap(array, a, b)
        array[a], array[b] = array[b], array[a]
    end

    def self.sort2!(array, start = 0, length = array.length, &prc)
        return array if length <= 1
        prc ||= Proc.new({|a, b| a <=> b})

        pivot_idx = partition(array, start, length, &prc)

        left_length = pivot_idx - start
        # right_length = length - pivot_idx - 1
        right_length = length - (left_length + 1)
        # right_length = length - pivot_idx + start - 1

        sort2!(array, start, left_length, &prc)
        sort2!(array, piv_idx + 1, right_length, &prc)

        return array
    end

    def partition(array, start, length, &prc)
        prc ||= Proc.new({|a, b| a <=> b})
        piv_idx = start
        piv_val = array[pivot_idx]

        ((start+1)...(length+start)).each do |curr_idx|
            curr_val = array[curr_idx]
            if prc.call(curr_val, piv_val) < 0
                piv_idx += 1
                swap(array, piv_idx, curr_idx)
            end
        end

        swap(array, start, piv_idx)

        return piv_idx
    end

end