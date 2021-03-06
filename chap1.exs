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

# PROBLEM THREE ---
# TAX TIME

to_dollers = fn(number) -> :erlang.float_to_binary(number, [decimals: 2]) end
Enum.each [12.5, 30.99, 250.49, 18.80], fn(x) -> IO.puts "Price: #{to_dollers.(x * 1.12)} - Tax: #{to_dollers.(x * 0.12)}" end

# PROBLEM FOUR ---
# Matchstick Factory
# large box holds 50
# medium holds 20
# small holds 5

defmodule MatchstickFactory  do
  def boxes(match_count, boxes \\ %{"large" => 0, "medium" => 0, "small" => 0, "remaining" => 0} ) do
    cond do
      match_count >= 50 ->
        updated_boxes = MatchstickFactory.match_matchbox_size("large", boxes)
        MatchstickFactory.boxes(match_count - 50, updated_boxes)
      match_count >= 20 ->
        updated_boxes = MatchstickFactory.match_matchbox_size("medium",  boxes)
        MatchstickFactory.boxes(match_count - 20, updated_boxes)
      match_count >= 5 ->
          updated_boxes = MatchstickFactory.match_matchbox_size("small",  boxes)
          MatchstickFactory.boxes(match_count - 5, updated_boxes)
      true ->
        updated_boxes_tuple = Map.get_and_update!(boxes, "remaining", fn val -> {val, match_count} end)
        elem(updated_boxes_tuple, 1)

    end
  end



  def match_matchbox_size(box_name, boxes) do
    updated_boxes_tuple = Map.get_and_update!(boxes, box_name, fn val ->
        {val, val+1}
    end)
    elem(updated_boxes_tuple, 1)
  end
end

order_details = MatchstickFactory.boxes(98)
IO.inspect order_details

IO.puts "--now with out recursion--"
starting_value =  98
large_count = div(starting_value, 50)
after_large = rem(starting_value, 50)
med_count = div(after_large, 20)
after_med = rem(after_large, 20)
small_count = div(after_med, 5)
after_small = rem(after_med, 5)


IO.puts large_count
IO.puts med_count
IO.puts small_count
IO.puts after_small


IO.puts "-------------"
test = [%{"name" => "large","size" => 50 },%{"name" => "medium","size" => 20 },%{"name" => "small","size" => 5 }]
Enum.each(test, fn(x)-> IO.inspect x end)
