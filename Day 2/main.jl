using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\r\n")

## Part 1

get_id(game::AbstractString)::Int = tryparse(Int, split(split(game, ":")[1], " ")[2])

function parse_data(game::AbstractString)::Vector{Dict{Any,Any}}
    game_string = split(game, ": ")[2]
    turns = split(game_string, "; ")
    game_data = split.(turns, ", ")
    dict_stuff = map(x -> map(y -> begin
                key, value = reverse(split(y, " "))
                value = tryparse(Int, value)
                return (key, value)
            end, x), game_data)
    dict = map(x -> Dict(x), dict_stuff)
    return dict
end

function game_legal(game::AbstractString)::Bool
    game_dict = parse_data(game)
    for round in game_dict
        if (get(round, "red", 0) > 12)
            return false
        end

        if (get(round, "green", 0) > 13)
            return false
        end

        if (get(round, "blue", 0) > 14)
            return false
        end
    end
    return true
end

println(sum(map(get_id,filter(game_legal,array_data))))

## Part 2

println(parse_data(array_data[1]))

function max_in_game(game::AbstractString)
    game_dict = parse_data(game)

    max_dict = Dict()
    max_dict["red"] = maximum(map(x -> get(x,"red",0),game_dict))
    max_dict["green"] = maximum(map(x -> get(x,"green",0),game_dict))
    max_dict["blue"] = maximum(map(x -> get(x,"blue",0),game_dict))
    return [max_dict["red"],max_dict["green"],max_dict["blue"]]
end

sum(map(prod,map(max_in_game,array_data)))