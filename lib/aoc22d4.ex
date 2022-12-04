defmodule Aoc22d4 do
  @moduledoc """
  Module for solving the questions of day 4 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day4.txt file.
  """
  def data do
    data("data/input/day4.txt")
  end

  @spec data(String.t()) :: list(list(integer))
  def data(file) do
    {:ok, data} = File.read(file)
    String.split(data, "\r\n")
    |> Enum.map(fn x -> String.split(x, ",") end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.split(y, "-") |> Enum.map(&String.to_integer/1) end) end)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    data
    |> Enum.map(fn x -> contain(x) end)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    data
    |> Enum.map(fn x -> contain_at_all(x) end)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  def contain([l1,l2]) do
    cond do
      !Range.disjoint?(Enum.at(l1,0)..Enum.at(l1,1), Enum.at(l2,0)..Enum.at(l2,0))
      and !Range.disjoint?(Enum.at(l1,0)..Enum.at(l1,1), Enum.at(l2,1)..Enum.at(l2,1)) ->
        true
      !Range.disjoint?(Enum.at(l2,0)..Enum.at(l2,1), Enum.at(l1,0)..Enum.at(l1,0))
      and !Range.disjoint?(Enum.at(l2,0)..Enum.at(l2,1), Enum.at(l1,1)..Enum.at(l1,1))->
        true
      true ->
        false
    end
  end

  def contain_at_all([l1,l2]) do
    !Range.disjoint?(Enum.at(l2,0)..Enum.at(l2,1), Enum.at(l1,0)..Enum.at(l1,1))
  end
end
