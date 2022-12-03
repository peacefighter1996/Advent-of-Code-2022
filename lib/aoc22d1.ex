defmodule Aoc22d1 do
  @moduledoc """
  Module for solving the questions of day 1 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day1.txt file.
  """
  def data do
    {:ok, data} = File.read("data/input_day1.txt")
    split1 = String.split(data, "\r\n\r\n")
    split2 = Enum.map(split1, fn x -> Enum.map(String.split(x, "\r\n"),
      fn y -> String.to_integer(y) end) end)
    summedSplit = split2 |> Enum.map(fn x -> Enum.reduce(x, 0, fn y, acc -> y + acc end) end)
    summedSplit
  end

  @doc """
  result of question 1
  """
  def question1 do
    question1(data())
  end

  def question1(data) do
    max = Enum.max(data)
    max
  end

  @doc """
  result of question 2
  """
  def question2 do
    question2(data())
  end

  def question2(data) do
    #sort data
    sortedData = Enum.sort(data, &(&1 >= &2))
    Enum.take(sortedData, 3) |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
end
