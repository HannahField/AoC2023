using FileIO

data = open("input.txt", "r")
#data = open("example_input.txt","r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\n\n")
#array_data = split(data,"\r\n\r\n")

# Part 1

seeds = tryparse.(Int,split(split(array_data[1],": ")[2]," "))

parser(data,index) = map(x -> tryparse.(Int,x),split.(split.(data[index],"\n")[2:end]," "))

ranges_parser(data) = [range(data[2],data[2]+data[3]-1), range(data[1],data[1]+data[3]-1)]

maps = map(x -> ranges_parser.(parser(array_data,x)),2:8)

function evaluate_map(mapping,value)
    in_range_index = findfirst(x -> x == 1, map(x -> value in x[1], mapping))
    if !isnothing(in_range_index)
        diff = value - minimum(mapping[in_range_index][1])
        return minimum(mapping[in_range_index][2])+diff
    else
        return value
    end
end

values = seeds

for mapping in maps
    global values = map(x -> evaluate_map(mapping,x),values)
end

minimum(values)

# Part 2
seeds2 = UnitRange{Int64}[]
for n in 1:div(length(seeds),2)
    append!(seeds2,[range(seeds[2*n-1],seeds[2*n-1]+seeds[2*n]-1)])
end

min_location = 2^30

for seedrange in seeds2
    println(seedrange)
    for seed in seedrange
        value = seed
        for mapping in maps
            value = evaluate_map(mapping,value)
        end
        if value < min_location
            println([seed,value])
            global min_location = value
        end
    end
end

min_location