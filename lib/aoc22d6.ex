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

  @spec data(String.t()) :: list(integer)
  def data(file) do
    {:ok, data} = File.read(file)
    String.to_charlist(data)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    initmask(Enum.take(data, 4))
    |> find_index(Enum.take(data, 4), Enum.drop(data, 4),4,false)
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    initmask(Enum.take(data, 14))
    |> find_index(Enum.take(data, 14), Enum.drop(data, 14),14, false)
  end

  def check_match(mask, x) do
    Enum.map(x..length(mask)-1, fn y -> Enum.at(mask,y) == Enum.at(mask,x) end)
    |> Enum.filter(fn x -> x == true end)
  end

  def initmask(mask) do
    initmask(%{},mask)
  end
  def initmask(maskmap,[]) do
    maskmap
  end
  def initmask(maskmap,mask) do
    if Map.has_key?(maskmap, Enum.at(mask,0)) do
      {:ok,value} = Map.fetch(maskmap, Enum.at(mask,0))
      Map.delete(maskmap, Enum.at(mask,0))
      |> Map.put(Enum.at(mask,0), value+1)
      |> initmask(Enum.drop(mask,1))
    else
      Map.put(maskmap, Enum.at(mask,0),1)
      |> initmask(Enum.drop(mask,1))
    end
  end

  def decrease(maskmap, x)do
    {:ok,value} = Map.fetch(maskmap, x)
    if value == 1 do
      Map.delete(maskmap, x)
    else
      Map.delete(maskmap, x)
      |> Map.put(x, value-1)
    end
  end

  def increase(maskmap, x)do
    if Map.has_key?(maskmap,x) do
      {:ok,value} = Map.fetch(maskmap, x)
      Map.delete(maskmap, x)
      |> Map.put(x, value+1)
    else
      Map.put(maskmap, x,1)
    end
  end
  def find_index(maskmap,mask,data, i, true) do
    i
  end
  def find_index(maskmap,mask,data, i, false) do
    maskmap
    |> decrease(Enum.at(mask,0))
    |> increase(Enum.at(data,0))
    |> find_index(Enum.drop(mask, 1) ++ [Enum.at(data, 0)], Enum.drop(data, 1), i+1, length(Map.keys(maskmap)) == length(mask))
  end
end
