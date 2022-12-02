defmodule Aoc2022.Day01 do
  import Aoc2022

  @doc """
  Find the elf with the most calories.
  """
  def part1(input_file \\ "day01.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> calories_per_elf()
    |> Enum.max()
  end

  @doc """
  Find the top 3 elves with the most calories and then sum.
  """
  def part2(input_file \\ "day01.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> calories_per_elf()
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp calories_per_elf(stream) do
    stream
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.chunk_by(& &1 == "")
    |> Stream.reject(& &1 == [""])
    |> Stream.map(fn list ->
      list
      |> Enum.map(&String.to_integer/1)
      |> Enum.sum()
    end)
  end
end
