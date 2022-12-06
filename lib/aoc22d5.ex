defmodule Aoc22d5 do
  @moduledoc """
  Module for solving the questions of day 5 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/input/day5.txt")
  end

  @spec data(String.t()) :: list(list(integer))
  def data(file) do
    {:ok, data} = File.read(file)
    data = String.split(data, "\r\n\r\n")
    [get_state(Enum.at(data,0)), get_instructions(Enum.at(data,1))]
  end

  @spec get_state(String.t()):: list(list(String.t()))
  def get_state(data) do
    IO.puts("Getting state")
    data = String.split(data, "\r\n")
    count = round((String.length(Enum.at(data,0)) +1)/4)
    IO.puts("filling stacks")
    range = 0..length(data)-2
    Enum.map(data, fn x -> Enum.map(range, String.at(x,1+4*x)) end)

     fn x-> Enum.map(range, fn y -> String.at(1+4*x) end) end)
    |> Enum.map(fn x ->Enum.filter(x, fn y -> y != " " end) end)
  end

  def get_instructions(data) do
    IO.puts("Getting instructions")
    data = String.split(data, "\r\n")
    |> Enum.map(fn x -> String.split(x, " ") end)
    Enum.map(data, fn y -> Enum.map(1..5//2, fn x-> String.to_integer(Enum.at(y,x)) end) end)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    execute9000(Enum.at(data, 1), Enum.at(data, 0))
    |> Enum.map(fn x -> to_charlist(Enum.at(x,0)) end)
    |> Enum.map(fn x -> Enum.at(x,0) end)

  end



  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    execute9001(Enum.at(data, 1), Enum.at(data, 0))
    |> Enum.map(fn x -> to_charlist(Enum.at(x,0)) end)
    |> Enum.map(fn x -> Enum.at(x,0) end)
  end

  def execute9000([], stacks) do stacks end
  def execute9000(instructions, stacks) do

    [a,b,c] = Enum.at(instructions, 0)
    IO.puts("move #{a} from #{b} to #{c}, instructions left:#{length(instructions)}")
    stacks_c = Enum.reverse(Enum.take(Enum.at(stacks,b-1), a)) ++ Enum.at(stacks,c-1)
    stacks_b = Enum.drop(Enum.at(stacks,b-1), a)
    execute9000(Enum.drop(instructions,1),Enum.map(0..length(stacks)-1, fn x -> cond do
      x==b-1 -> stacks_b
      x==c-1 -> stacks_c
      true -> Enum.at(stacks, x)
    end end))
  end

  def execute9001([], stacks) do stacks end
  def execute9001(instructions, stacks) do
    [a,b,c] = Enum.at(instructions, 0)
    IO.puts("move #{a} from #{b} to #{c}, instructions left:#{length(instructions)}")
    stacks_c = Enum.take(Enum.at(stacks,b-1), a) ++ Enum.at(stacks,c-1)
    stacks_b = Enum.drop(Enum.at(stacks,b-1), a)
    execute9001(Enum.drop(instructions,1),Enum.map(0..length(stacks)-1, fn x -> cond do
      x==b-1 -> stacks_b
      x==c-1 -> stacks_c
      true -> Enum.at(stacks, x)
    end end))
  end
end
