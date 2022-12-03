defmodule Aoc22d3 do
  @moduledoc """
  Module for solving the questions of day 3 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day3.txt file.
  """
  def data do
    {:ok, data} = File.read("data/input_day3.txt")
    String.split(data, "\r\n")
    #split string in half

  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    data
    |> Enum.map(fn x -> [ to_charlist(String.slice(x,0..Integer.floor_div(String.length(x)-1,2))),
                          to_charlist(String.slice(x,Integer.floor_div(String.length(x),2)..String.length(x)-1))
                        ] end)
    |> Enum.map(fn x -> getCommon(x) end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  def getCommon([l1,l2]) do
    # string to list
    Enum.map(l1, fn x -> if Enum.member?(l2, x), do: x, else: nil end)
    |> getListValue()
  end

  @spec getListValue(list(char)) :: integer
  def getListValue(list) do
    Enum.filter(list, fn x -> x != nil end)
    |> Enum.reduce([], fn x, acc -> if Enum.member?(acc, x), do: acc, else: [x | acc] end)
    |> Enum.map(fn x -> getValue(x) end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end

  @spec getValue(char) :: integer
  def getValue(v) do
  # for each character check if upper if so add char ascii value - 64 +26 else add char ascii value - 96
    if v in ?A..?Z, do: v - 64 + 26, else: v - 96
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    # group each 3 lines
    data
    |> Enum.map(fn x -> to_charlist(x) end)
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> getBadge(x) end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
  end
  def getBadge([l1,l2,l3]) do
    Enum.map(l1, fn x -> if Enum.member?(l2, x) && Enum.member?(l3, x), do: x, else: nil end)
    |> getListValue()
  end
end
