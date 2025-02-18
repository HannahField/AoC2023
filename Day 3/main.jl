using FileIO
using LinearAlgebra

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\r\n")

# Part 1

matrix_data = reshape(reduce(hcat, (collect.(array_data))), (140, 140))

function get_neighbors(index::Tuple{Int,Int}, size::Tuple{Int,Int})
    local_indices = [
        (-1, -1);
        (-1, 0);
        (-1, 1);
        (0, -1);
        (0, 0);
        (0, 1);
        (1, -1);
        (1, 0);
        (1, 1)]
    indices = map(x -> x .+ index, local_indices)
    filter!(x -> all(x .>= 1) && all(x .<= size), indices)
    return indices
end

symbol_indices = filter(x -> !(matrix_data[x] in ".1234567890"), CartesianIndices(matrix_data))

digit_indices_valid = CartesianIndex.(
    filter(x -> (matrix_data[x...] in "1234567890"),
        collect(Iterators.flatten(
            map(y -> get_neighbors(
                    (y[1], y[2]), size(
                        matrix_data)), symbol_indices)))))

function normalize_index(index, data)
    left = CartesianIndex(-1, 0)
    while (true)
        if (index[1] + left[1] > 0 && data[index+left] in "1234567890")
            index = index + left
        else
            return index
        end
    end
end

normalized_set = Set(map(x -> normalize_index(x, matrix_data), digit_indices_valid))

function get_full_number(index, data)
    right = CartesianIndex(1, 0)
    result = ""
    result = result * data[index]
    while (true)
        if (index[1] + right[1] <= size(data)[1] && data[index+right] in "1234567890")
            index = index + right
            result = result * data[index]
        else
            break
        end
    end
    return tryparse(Int, result)
end

sum(map(x -> get_full_number(x, matrix_data), collect(normalized_set)))


# Part 2

star_indices = filter(x -> (matrix_data[x] == '*'), CartesianIndices(matrix_data))

global value = 0

for index in star_indices
    neighbors = get_neighbors(Tuple(index),size(matrix_data))
    filter!(x -> matrix_data[CartesianIndex(x)] in "1234567890", neighbors)
    normalized_index = map(x -> normalize_index(CartesianIndex(x),matrix_data),neighbors)
    numbers = Set(map(x -> get_full_number(CartesianIndex(x), matrix_data), normalized_index))
    if (length(numbers) > 1)
         global value = value + prod(collect(numbers))
    end
end
print(value)