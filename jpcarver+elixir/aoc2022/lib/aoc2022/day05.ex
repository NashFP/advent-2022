defmodule Aoc2022.Day05 do
  def part1(input_file \\ "day05.txt") do
    input_file
    |> read_file()
    |> pick_up_crates(:one_at_a_time)
  end

  def part2(input_file \\ "day05.txt") do
    input_file
    |> read_file()
    |> pick_up_crates(:multiple)
  end

  def pick_up_crates([stack_lines, instruction_lines], crane_ability) do
    stack_lines
    |> stacks()
    |> perform_instructions(instruction_lines, crane_ability)
    |> top_crates()
  end

  def top_crates(stacks) do
    stacks
    |> Enum.sort(fn {index1, _}, {index2, _} -> index1 <= index2 end)
    |> Enum.map_join(fn {_index, [head | _]} -> head end)
  end

  def perform_instructions(stacks, instruction_lines, crane_ability) do
    Enum.reduce(instruction_lines, stacks, fn line, acc ->
      [move, from, to] = instruction(line)
      {moving, remainder} = Map.get(acc, from) |> Enum.split(move)

      sorted_moving =
        case crane_ability do
          :one_at_a_time -> Enum.reverse(moving)
          :multiple -> moving
          _ -> raise("#{crane_ability} is not a valid crane ability")
        end

      acc
      |> Map.put(from, remainder)
      |> Map.update!(to, & sorted_moving ++ &1)
    end)
  end

  def instruction(line) do
    Regex.scan(~r/\d{1,2}/, line)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  def stacks(lines) do
    number_line = List.last(lines)
    stacks = empty_stacks(number_line)
    crate_lines = lines |> Enum.drop(-1) |> Enum.reverse()

    Enum.reduce(crate_lines, stacks, fn line, acc ->
      crates = line_to_crates(line)
      Map.merge(acc, crates, fn _v, k1, k2 -> [k2 | k1] end)
    end)
  end

  def line_to_crates(line) do
    line
    |> String.graphemes
    |> tl()
    |> Enum.with_index()
    |> Enum.filter(fn {token, index} -> rem(index, 4) == 0 && token != " " end)
    |> Enum.map(fn {crate, index} -> {div(index, 4) + 1, crate} end)
    |> Map.new()
  end

  def empty_stacks(lines) do
    lines
    |> String.split(" ", trim: true)
    |> Enum.map(& {String.to_integer(&1), []})
    |> Map.new()
  end

  def read_file(input_file) do
    "priv/" <> input_file
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(& String.split(&1, "\n"))
  end
end
