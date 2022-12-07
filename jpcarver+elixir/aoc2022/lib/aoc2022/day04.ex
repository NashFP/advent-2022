defmodule Aoc2022.Day04 do
  def part1(input_file \\ "day04.txt"), do:
    run(input_file, &is_one_inside_the_other/1)

  def part2(input_file \\ "day04.txt"), do:
    run(input_file, &does_intersect/1)

  def run(input_file, fun) do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(&parse/1)
    |> Enum.reduce(0, fn pairs, acc ->
      if fun.(pairs), do: acc + 1, else: acc
    end)
  end

  def is_one_inside_the_other([first_pair, second_pair]), do:
    is_inside(first_pair, second_pair) || is_inside(second_pair, first_pair)

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
