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

  @spec get_state(String.t()):: integer
  def get_state(data) do
    data = String.split(data, "\r\n")
    count = round((String.length(Enum.at(data,0)) +1)/4)
    #row = Enum.take(data, data.length - 1)
    #[row, count]
    #create amount of arrays equal to the count
    Enum.map(0..count-1, fn x-> Enum.map(0..length(data)-2, fn y -> String.at(Enum.at(data,y),1+4*x) end) end)
    # filer " "
    |> Enum.map(fn x ->Enum.filter(x, fn y -> y != " " end) end)
  end

  def get_instructions(data) do
    data = String.split(data, "\r\n")
    |> Enum.map(fn x -> String.split(x, " ") end)
    # get all even count
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

  def execute9000(instructions, stacks) do
    if length(instructions) != 0 do
      #Enum.map(stacks, fn x-> IO.puts(x) end)
      #IO.puts("=====================================")
      [a,b,c] = Enum.at(instructions, 0)
      # move a items from stack b to stack c
      stacks_c = Enum.reverse(Enum.take(Enum.at(stacks,b-1), a)) ++ Enum.at(stacks,c-1)
      stacks_b = Enum.drop(Enum.at(stacks,b-1), a)
      execute9000(Enum.drop(instructions,1),Enum.map(0..length(stacks)-1, fn x -> cond do
        x==b-1 -> stacks_b
        x==c-1 -> stacks_c
        true -> Enum.at(stacks, x)
      end end))
    else
      stacks
    end
  end

  def execute9001(instructions, stacks) do
    if length(instructions) != 0 do
      #Enum.map(stacks, fn x-> IO.puts(x) end)
      #IO.puts("=====================================")
      [a,b,c] = Enum.at(instructions, 0)
      # move a items from stack b to stack c
      stacks_c = Enum.take(Enum.at(stacks,b-1), a) ++ Enum.at(stacks,c-1)
      stacks_b = Enum.drop(Enum.at(stacks,b-1), a)
      execute9001(Enum.drop(instructions,1),Enum.map(0..length(stacks)-1, fn x -> cond do
        x==b-1 -> stacks_b
        x==c-1 -> stacks_c
        true -> Enum.at(stacks, x)
      end end))
    else
      stacks
    end
  end
end
