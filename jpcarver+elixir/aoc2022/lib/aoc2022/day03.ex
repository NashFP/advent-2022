defmodule Aoc2022.Day03 do
  def part1(input_file \\ "day03.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.reduce(0, fn rucksack, acc ->
      compartment_size = div(String.length(rucksack), 2)

      {first, second} =
        rucksack
        |> String.graphemes()
        |> Enum.map(&to_value/1)
        |> Enum.split(compartment_size)

      common =
        MapSet.new(first)
        |> MapSet.intersection(MapSet.new(second))
        |> MapSet.to_list()
        |> hd()

      acc + common
    end)
  end

  def part2(input_file \\ "day03.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(fn line ->
      line
      |> String.trim_trailing()
      |> String.graphemes()
      |> Enum.map(&to_value/1)
      |> MapSet.new()
    end)
    |> Stream.chunk_every(3)
    |> Stream.map(fn [rucksack1, rucksack2, rucksack3] ->
      rucksack1
      |> MapSet.intersection(rucksack2)
      |> MapSet.intersection(rucksack3)
      |> MapSet.to_list()
      |> hd()
    end)
    |> Enum.sum()
  end

  def to_value(letter) do
    <<num::utf8>> = letter
    if letter == String.upcase(letter) do
      num - 38
    else
      num - 96
    end
  end
end
