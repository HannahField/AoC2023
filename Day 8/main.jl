using FileIO

data = open("input.txt", "r")
#data = open("example_input.txt","r")
data = read(data, String)
data = strip(data)
walk_s, maps = split(data, "\n\n")

walk = parse.(Int,collect(replace(walk_s,"L" => 1, "R" => 2))) 

maps = split(maps,"\n")
maps = Dict(map(x -> x[1:3] => (x[8:10],x[13:15]),maps))

# 1

current_position = "AAA"
n = 0
while(current_position != "ZZZ")
    global current_position = maps[current_position][walk[(n % length(walk)) + 1]]
    global n += 1
end
println(n)

# 2
current_positions = collect(filter(x -> x[3] == 'A',keys(maps))) 
n = 0

while(any((map(x -> x[3] != 'Z',current_positions))))
    global current_positions = map(x -> maps[x][walk[(n % length(walk)) + 1]],current_positions)
    global n += 1
end
println(n)

