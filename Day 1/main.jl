using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\r\n")

#1
valid_chars = "0123456789"
filtered_array = map(y -> filter(x -> x in valid_chars, y), array_data)
first_last_digits = parse.(Int,map(x -> x[1] * x[end], filtered_array))

#2

digits_in_text = Dict(
    [("one", "one1one"),
    ("two", "two2two"),
    ("three", "three3three"),
    ("four", "four4four"),
    ("five", "five5five"),
    ("six", "six6six"),
    ("seven", "seven7seven"),
    ("eight", "eight8eight"),
    ("nine", "nine9nine")]
)

part_2_data = map(x -> foldl((y,z) -> replace(y, z[1] => z[2]),digits_in_text,init = x), array_data)
part_2_filtered_array = map(y -> filter(x -> x in valid_chars, y), part_2_data)
part_2_first_last_digits = parse.(Int, map(x -> x[1] * x[end], part_2_filtered_array))
println(sum(part_2_first_last_digits))