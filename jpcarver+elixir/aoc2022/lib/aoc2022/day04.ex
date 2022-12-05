defmodule Aoc2022.Day04 do
  def part1(input_file \\ "day04.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(&parse/1)
    |> Enum.reduce(0, fn pairs, acc ->
      if is_one_inside_the_other(pairs), do: acc + 1, else: acc
    end)
  end

  def part2(input_file \\ "day04.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(&parse/1)
    |> Enum.reduce(0, fn pairs, acc ->
      if does_intersect(pairs), do: acc + 1, else: acc
    end)
  end

  def is_one_inside_the_other([first_pair, second_pair]) do
    first_inside_second = is_inside(first_pair, second_pair)
    second_inside_first = is_inside(second_pair, first_pair)

    case {first_inside_second, second_inside_first} do
      {true, false} -> true
      {false, true} -> true
      {true, true} -> true
      {false, false} -> false
    end
  end

  def is_inside([start1, finish1], [start2, finish2])
    when start1 >= start2 and finish1 <= finish2, do: true

  def is_inside(_first, _second), do: false

  def does_intersect([[first_start, first_finish], [second_start, second_finish]]) do
    !Range.disjoint?(first_start..first_finish, second_start..second_finish)
  end

  def parse(line) do
    line
    |> String.trim_trailing()
    |> String.split(",")
    |> Enum.map(fn range ->
      range
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
