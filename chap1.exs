# PROBLEM ONE ----
# Create an expression that solves the problem:
# Sara has bought
# - ten slices of bread for ten cents each
# - three bottles of milk for two dollers
# - a cake for $15 each
# how much has she spent

bread = 0.10
milk = 2.0
cake = 15
item_cost = fn(item, quantity) -> item * quantity end
total_cost = item_cost.(bread, 10) + item_cost.(milk, 3) + item_cost.(cake, 1)
IO.puts total_cost


# PROBLEM TWO ----
# BOB has traveled 200 KM in four hours.
# Using variables, print a message showing his travel distance, time, and average velocity.

distance_traveled = 200
time_in_hours = 4
time_in_minutes = time_in_hours * 60
velocity = distance_traveled/time_in_minutes
IO.puts velocity
