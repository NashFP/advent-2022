defmodule Aoc2022.Day02 do



  def part1(input_file \\ "day02.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(fn <<opponent::binary-size(1), " ", mine::binary-size(1)>> ->
      round_score(translate(opponent), translate(mine))
    end)
    |> Enum.sum()

  end

  def part2(input_file \\ "day02.txt") do
    "priv/" <> input_file
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Stream.map(fn <<opponent::binary-size(1), " ", strategy::binary-size(1)>> ->
      opponent = translate(opponent)
      strategy = translate_strategy(strategy)
      mine = my_play(opponent, strategy)

      round_score(opponent, mine)
    end)
    |> Enum.sum()
  end

  def my_play(opponent, :draw), do: opponent

  def my_play(:rock, :lose), do: :scissors
  def my_play(:paper, :lose), do: :rock
  def my_play(:scissors, :lose), do: :paper

  def my_play(:rock, :win), do: :paper
  def my_play(:paper, :win), do: :scissors
  def my_play(:scissors, :win), do: :rock

  def round_score(opponent, mine) do
    selection_score = selection_score(mine)
    outcome_score = outcome_score(opponent, mine)

    selection_score + outcome_score
  end

  def selection_score(:rock), do: 1
  def selection_score(:paper), do: 2
  def selection_score(:scissors), do: 3

  def outcome_score(same, same), do: 3

  def outcome_score(:scissors, :rock), do: 6
  def outcome_score(:rock, :paper), do: 6
  def outcome_score(:paper, :scissors), do: 6

  def outcome_score(_, _), do: 0

  def translate("A"), do: :rock
  def translate("B"), do: :paper
  def translate("C"), do: :scissors

  def translate("X"), do: :rock
  def translate("Y"), do: :paper
  def translate("Z"), do: :scissors

  def translate_strategy("X"), do: :lose
  def translate_strategy("Y"), do: :draw
  def translate_strategy("Z"), do: :win
end
