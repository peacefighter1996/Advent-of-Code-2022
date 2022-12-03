defmodule Aoc22d3 do
  @moduledoc """
  Module for solving the questions of day 3 of Advent of Code 2022.
  """

  @spec data :: list(list(String))
  @doc """
  Get the input data from the data/input.txt file.
  """
  def data do
    {:ok, data} = File.read("data/input_day3.txt")
    String.split(data, "\r\n")
    #split string in half
    |> Enum.map(fn x -> [String.slice(x,0..Integer.floor_div(String.length(x),2)),
                         String.slice(x,Integer.floor_div(String.length(x),2)+1..String.length(x)-1)
                        ] end)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    Enum.map(data, fn x -> [Enum.uniq(x[0]),Enum.uniq(x[0])] end)
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
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

    data
    |> Enum.map(fn x -> map[x] end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end
