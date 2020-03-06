defmodule Format_puzzle do
  def into_map(unformated_string) do
    one_long_array = String.split(unformated_string, "")
    row_one =  array_to_map(Enum.slice(one_long_array, 1, 9))
    row_two = array_to_map(Enum.slice(one_long_array, 10, 9))
    row_three = array_to_map(Enum.slice(one_long_array, 19, 9))
    row_four = array_to_map(Enum.slice(one_long_array, 28, 9))
    row_five = array_to_map(Enum.slice(one_long_array, 37, 9))
    row_six = array_to_map(Enum.slice(one_long_array, 46, 9))
    row_seven = array_to_map(Enum.slice(one_long_array, 55, 9))
    row_eight = array_to_map(Enum.slice(one_long_array, 64, 9))
    row_nine = array_to_map(Enum.slice(one_long_array, 73, 9))

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

  def find_next_open_cell(grid, x \\ 0, y \\ 0) do
    # IO.puts "x:#{x} y:#{y} item at that position:#{grid[x][y]}"
    cond do
      is_empty(grid, x, y) == false ->
        {x, y}
      y >= 8 && x >= 8 ->
        true
      y >= 8 ->
        find_next_open_cell(grid, x+1, 0)
      true ->
        find_next_open_cell(grid, x, y+1)
    end
  end

  def is_empty(grid, x, y) do
    {cell_item_a, _} = Integer.parse(grid[x][y])

    if cell_item_a != 0 do
      true
    else
      false
    end
  end

  def get_row(grid, x) do
    array_of_row = Map.values(grid[x])
    {array_of_row, length(array_of_row)}
  end

  def get_column(grid, y) do
    Enum.flat_map_reduce(grid, 0, fn x, acc ->
      {_, xmap} = x
      {[xmap[y]], acc + 1}
    end)
  end

  def get_ninth(grid, x, y) do
    x_third = div(x, 3)
    y_third = div(y, 3)
    x_items = [x_third, x_third + 1, x_third + 1]
    y_items = [y_third, y_third + 1, y_third + 1]


    Enum.each(x_third, fn x ->
      IO.puts(x)
    end)


  end
end


# if needed use https://www.poeticoding.com/processing-large-csv-files-with-elixir-streams/ for the final bit
sodoku_puzzels = File.read!("sodoku_data_single.csv")
|> String.split("\n")
|> Enum.map(&String.split(&1, ","))
|> Enum.filter(fn
  [""] -> false
  [_,_] -> true
end)




[first_puzzle | _puzzles ] = sodoku_puzzels
[unsolved, solved] = first_puzzle
unsolved_grid = Format_puzzle.into_map(unsolved)
solved_grid = Format_puzzle.into_map(solved)

IO.inspect Format_puzzle.grid_to_list(unsolved_grid, "unsolved_grid")
# IO.inspect Format_puzzle.grid_to_list(solved_grid,"solved_grid")

# IO.inspect Sodoku_solve.find_next_open_cell(unsolved_grid)

IO.inspect Sodoku_solve.get_row(unsolved_grid, 0)
IO.inspect Sodoku_solve.get_column(unsolved_grid, 0)
