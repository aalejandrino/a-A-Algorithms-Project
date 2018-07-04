def find_single_element(arr)
    return false if arr.length <= 1

    mid = arr.length / 2
    first = arr[mid]

    return arr[mid] if is_unique(arr, mid)
    
    if is_unique(arr,mid) == (mid-1)
        left = arr[0...mid-1]
        find_single_element(left)
    else
        right = arr[mid+2...arr.length]
        find_single_element(right)
    end

end

def is_unique(arr, idx)
    if (arr[idx-1] == arr[idx])
        return (idx-1)
        
    elsif (arr[idx+1] == arr[idx])
        return (idx+1)
    else
        return true
    end
end