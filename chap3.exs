# chap3 -- Using pattern matching to control the program flow

x = 1

# what is this nonsense?!
IO.puts 1 = x

# this is called the pin operator, it stops rebinding and only checks equivilencies
IO.puts ^x = 1

# you can use <> to string match
"Authentication: " <> credentials = "Authentication: basic 123123"
IO.puts credentials
