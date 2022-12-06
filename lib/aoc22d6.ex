defmodule Aoc22d6 do
  @moduledoc """
  Module for solving the questions of day 5 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/input/day6.txt")
  end

  @spec data(String.t()) :: string
  def data(file) do
    {:ok, data} = File.read(file)
    String.to_charlist(data)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    find_index(Enum.take(data, 4), Enum.drop(data, 4),4)
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    find_index(Enum.take(data, 14), Enum.drop(data, 14),14)
  end

  def check_match(mask, x) do
    Enum.map(0..length(mask)-1, fn y -> Enum.at(mask,y) == Enum.at(mask,x) end)
    |> Enum.filter(fn x -> x == true end)
  end

  def find_index(mask,data, i) do
    result = Enum.map(0..length(mask)-1,fn x-> check_match(mask,x) end) |> Enum.count(fn x -> x == [true] end)
    if result == length(mask) do
      i
    else
      newMask = Enum.drop(mask, 1) ++ [Enum.at(data,0)]
      find_index(newMask, Enum.drop(data, 1), i+1)
    end
  end
end
