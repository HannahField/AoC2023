using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\n\n")

seeds = split(split(array_data[1],": ")[2]," ")

seed_to_soil_map = split.(split(array_data[2],"\n")[2:end], " ")
soil_to_fertilizer_map = split.(split(array_data[3],"\n")[2:end], " ")
fertilizer_to_water_map = split.(split(array_data[4],"\n")[2:end], " ")
water_to_light_map = split.(split(array_data[5],"\n")[2:end], " ")
light_to_temperature_map = split.(split(array_data[6],"\n")[2:end], " ")
temperature_to_humidity_map = split.(split(array_data[7],"\n")[2:end], " ")
humidity_to_location_map = split.(split(array_data[8],"\n")[2:end], " ")

