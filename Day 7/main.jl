using FileIO
using StatsBase

data = open("input.txt", "r")
#data = open("example_input.txt","r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\n")

# 1

hands_string = map(x -> x[1], split.(array_data, " "))
bets = tryparse.(Int, map(x -> x[2], split.(array_data, " ")))

card_values = Dict('A' => 14,
    'K' => 13,
    'Q' => 12,
    'J' => 11,
    'T' => 10,
    '9' => 9,
    '8' => 8,
    '7' => 7,
    '6' => 6,
    '5' => 5,
    '4' => 4,
    '3' => 3,
    '2' => 2)



function hand_type(hand::AbstractString)
    cards_count = values(countmap(hand))
    if (any(cards_count .== 5))
        return 6
    elseif (any(cards_count .== 4))
        return 5
    elseif (any(cards_count .== 3) && any(cards_count .== 2))
        return 4
    elseif (any(cards_count .== 3))
        return 3
    elseif (sum(cards_count .== 2) == 2)
        return 2
    elseif (any(cards_count .== 2))
        return 1
    else
        return 0
    end
end

map_hand(hand) = (hand_type(hand) << 20) |
                 (card_values[hand[1]] << 16) |
                 (card_values[hand[2]] << 12) |
                 (card_values[hand[3]] << 8) |
                 (card_values[hand[4]] << 4) |
                 (card_values[hand[5]])

struct Hand
    value::Int
    bet::Int
    identifier::AbstractString
end

hands = map(x -> Hand(map_hand(x[1]), parse(Int, x[2]), x[1]), split.(array_data, " "))

hands = sort(hands, by=x -> x.value)

println(sum(map(x -> x[1] * x[2].bet, enumerate(hands))))


# 2

card_values = Dict('A' => 14,
    'K' => 13,
    'Q' => 12,
    'J' => 1,
    'T' => 10,
    '9' => 9,
    '8' => 8,
    '7' => 7,
    '6' => 6,
    '5' => 5,
    '4' => 4,
    '3' => 3,
    '2' => 2)

function hand_type2(hand::AbstractString)
    chars = collect("AKQT987654321")
    return maximum(map(x -> hand_type(replace(hand, "J" => x)), chars))
end

map_hand2(hand) = (hand_type2(hand) << 20) |
                 (card_values[hand[1]] << 16) |
                 (card_values[hand[2]] << 12) |
                 (card_values[hand[3]] << 8) |
                 (card_values[hand[4]] << 4) |
                 (card_values[hand[5]])



hands2 = map(x -> Hand(map_hand2(x[1]), parse(Int, x[2]), x[1]), split.(array_data, " "))

hands2 = sort(hands2, by=x -> x.value)

println(sum(map(x -> x[1] * x[2].bet, enumerate(hands2))))