using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\r\n")

# Part 1

get_id(card::AbstractString) = tryparse(Int,filter(!isempty,split(split(card,": ")[1]," "))[2])
get_winning_numbers_vector(card::AbstractString) = tryparse.(Int, split(split(split(card, ": ")[2], " | ")[1], " "))
get_card_numbers_vector(card::AbstractString) = tryparse.(Int, filter(!isempty, split(split(split(card, ": ")[2], " | ")[2], " ")))
number_of_matches(card::AbstractString) = length(filter(x -> x in get_winning_numbers_vector(card),get_card_numbers_vector(card)))
points_from_matches(matches::Int) = (2^matches)÷2


sum(points_from_matches.(number_of_matches.(array_data)))

# Part 2

cards = Dict(map(x -> (get_id(x), 1),array_data))

for card in array_data
    matches = number_of_matches(card)
    for n in 1:matches
        cards[get_id(card)+n] = cards[get_id(card)] + cards[get_id(card)+n]
    end
end

sum(values(cards))