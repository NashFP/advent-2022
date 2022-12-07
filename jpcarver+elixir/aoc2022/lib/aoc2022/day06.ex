defmodule Aoc2022.Day06 do
  def part1(input_file \\ "day06.txt") do
    "priv/" <> input_file
    |> File.read!()
    |> String.graphemes()
    |> location_of_first_marker(4)
  end

  def part2(input_file \\ "day06.txt") do
    "priv/" <> input_file
    |> File.read!()
    |> String.graphemes()
    |> location_of_first_marker(14)
  end

  def location_of_first_marker(all_chars, size) do
    {first, remaining} = Enum.split(all_chars, size - 1)
    do_location_of_first_marker(first, remaining, size)
  end

  def do_location_of_first_marker(_, [], _) do
    raise "Did not find a start of packet marker"
  end

  def do_location_of_first_marker(chars, [next | tail], location) do
    new_chars = chars ++ [next]
    if Enum.uniq(new_chars) == new_chars do
      location
    else
      do_location_of_first_marker(tl(new_chars), tail, location + 1)
    end
  end
end
