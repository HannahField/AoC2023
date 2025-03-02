using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)
array_data = split(data, "\r\n\r\n")


