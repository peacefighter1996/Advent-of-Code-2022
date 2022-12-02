defmodule Aoc222 do
  @moduledoc """
  Module for solving the questions of day 2 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input.txt file.
  """
  def data do
    {:ok, data} = File.read("data/input.txt")
    String.split(data, "\r\n") 
  end

  @doc """
  result of question 1
  """
  def question1 do
    rock = 1
    paper = 2
    scissors = 3
    lose = 0
    win = 6
    draw = 3 

    map = %{
      "A X" => draw + rock,
      "A Y" => win  + paper,
      "A Z" => lose + scissors,
      "B X" => lose + rock,
      "B Y" => draw + paper,
      "B Z" => win  + scissors,
      "C X" => win  + rock,
      "C Y" => lose + paper,
      "C Z" => draw + scissors
    }

    data()
    |> Enum.map(fn x -> map[x] end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  @doc """
  result of question 2
  """
  def question2 do
    rock = 1
    paper = 2
    scissors = 3
    lose = 0
    win = 6
    draw = 3 

    map = %{
      "A X" => lose + scissors,
      "A Y" => draw + rock,
      "A Z" => win  + paper,
      "B X" => lose + rock,
      "B Y" => draw + paper,
      "B Z" => win  + scissors,
      "C X" => lose + paper,
      "C Y" => draw + scissors,
      "C Z" => win  + rock
    }

    data()
    |> Enum.map(fn x -> map[x] end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end
