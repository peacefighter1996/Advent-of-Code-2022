defmodule Aoc221 do
  @moduledoc """
  Documentation for `Aoc221`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Aoc221.hello()
      :world

  """
  def data do
    {:ok, data} = File.read("data/input.txt")
    split1 = String.split(data, "\r\n\r\n")
    split2 = Enum.map(split1, fn x -> Enum.map(String.split(x, "\r\n"), 
      fn y -> String.to_integer(y) end) end)
    summedSplit = split2 |> Enum.map(fn x -> Enum.reduce(x, 0, fn y, acc -> y + acc end) end)
    summedSplit
  end

  def headElf do
    max = Enum.max(data())
    max
  end

  def headCouncil do
    #sort data
    sortedData = Enum.sort(data(), &(&1 >= &2))
    Enum.take(sortedData, 3) |> Enum.reduce(0, fn x, acc -> x + acc end)
    
  end
end
