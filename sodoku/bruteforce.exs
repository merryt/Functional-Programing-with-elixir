defmodule Format_puzzle do

  def into_map(unformated_string) do
    one_long_array = String.split(unformated_string, "", trim: true)
    |> Enum.map(fn x ->
      {value, _} = Integer.parse(x)
      value
    end)
    row_one =  array_to_map(Enum.slice(one_long_array, 0, 9))
    row_two = array_to_map(Enum.slice(one_long_array, 9, 9))
    row_three = array_to_map(Enum.slice(one_long_array, 18, 9))
    row_four = array_to_map(Enum.slice(one_long_array, 27, 9))
    row_five = array_to_map(Enum.slice(one_long_array, 36, 9))
    row_six = array_to_map(Enum.slice(one_long_array, 45, 9))
    row_seven = array_to_map(Enum.slice(one_long_array, 54, 9))
    row_eight = array_to_map(Enum.slice(one_long_array, 63, 9))
    row_nine = array_to_map(Enum.slice(one_long_array, 72, 9))
    array_to_map([row_one, row_two, row_three, row_four, row_five, row_six, row_seven, row_eight, row_nine])
  end

  def array_to_map(array) do
    0..length(array)-1 |> Stream.zip(array) |> Enum.into(%{})
  end

  def grid_to_list(grid, name \\ "sodoku") do
    IO.puts "~~~~~~~~~~~~~~~~~"
    IO.puts "~ #{name} ~"
    Enum.each grid, fn {_k, row} ->
      IO.puts Enum.into(row, [], fn {_k, v} -> "#{v} " end)
    end
    IO.puts "~~~~~~~~~~~~~~~~~"
  end

end


defmodule Sodoku_solve do

  def solve(grid, x \\ 0, y \\ 0) do

    new_grid = solve_square(grid, x, y)


    # IO.puts "working on: #{x}, #{y}"
    # IO.inspect Format_puzzle.grid_to_list(new_grid, "In progress Grid")
    # IO.inspect new_grid
    # IO.puts "----"
    cond do
      is_solved(new_grid) == true ->
        new_grid
      y >= 8 && x >= 8 ->
        new_grid
      y >= 8 ->
        solve(new_grid, x+1, 0)
      true ->
        solve(new_grid, x, y+1)
    end
  end

  def is_solved(new_grid) do
    false
  end

  def solve_square(grid, x , y) do
    row = get_row(grid, x)
    column = get_column(grid, y)
    ninth =  get_ninth(grid, x, y)
    connected_values = Enum.uniq(row ++ column ++ ninth)
    |> Enum.sort

    if Enum.count(connected_values) == 9 do
      new_val = Enum.reduce_while(connected_values, 0, fn x, acc ->
        if acc == x, do: {:cont, acc + 1}, else: {:halt, acc}
      end)
      put_in(grid, [x,y], new_val )
    else
      grid
    end
  end

  # def find_next_open_cell(grid, x \\ 0, y \\ 0) do
  #   # IO.puts "x:#{x} y:#{y} item at that position:#{grid[x][y]}"
  #   cond do
  #     is_empty(grid, x, y) == false ->
  #       {x, y}
  #     y >= 8 && x >= 8 ->
  #       {0,0}
  #     y >= 8 ->
  #       find_next_open_cell(grid, x+1, 0)
  #     true ->
  #       find_next_open_cell(grid, x, y+1)
  #   end
  # end

  def is_empty(grid, x, y) do
    grid[x][y] != 0
  end

  def get_row(grid, x) do
    Map.values(grid[x])
  end

  def get_column(grid, y) do
    Enum.map(grid, fn x->
      {_, xmap} = x
      xmap[y]
    end)
  end

  def get_ninth(grid, x, y) do
    x_third = div(x, 3)*3
    y_third = div(y, 3)*3
    x_items = [x_third, x_third + 1, x_third + 2]
    y_items = [y_third, y_third + 1, y_third + 2]


    Enum.flat_map(x_items, fn x ->
      Enum.map(y_items, fn y ->
        grid[x][y]
      end)
    end)
  end

end


# if needed use https://www.poeticoding.com/processing-large-csv-files-with-elixir-streams/ for the final bit
sodoku_puzzles = File.read!("sodoku_data_single.csv")
|> String.split("\n")
|> Enum.map(&String.split(&1, ","))
|> Enum.filter(fn
  [""] -> false
  [_,_] -> true
end)




[first_puzzle | _puzzles ] = sodoku_puzzles
[unsolved, solved] = first_puzzle
unsolved_grid = Format_puzzle.into_map(unsolved)
solved_grid = Format_puzzle.into_map(solved)


IO.inspect Format_puzzle.grid_to_list(unsolved_grid, "Unsolved Grid")
IO.inspect Format_puzzle.grid_to_list(solved_grid,"Solved Grid")

# IO.inspect Sodoku_solve.get_row(unsolved_grid, 0)

Sodoku_solve.solve(unsolved_grid, 0, 8)
|> Format_puzzle.grid_to_list("My try")
