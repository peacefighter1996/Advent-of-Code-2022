defmodule Aoc22d10 do
  @moduledoc """
  Module for solving the questions of day 10 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/input/day10.txt")
  end

  def data(file) do
    {:ok, data} = File.read(file)
    String.split(data, "\r\n")
    |> Enum.map(fn x -> String.split(x," ") end)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    array = execute(data)
    #Enum.map(array, fn x -> IO.inspect(x)  end)
    v =      [Enum.at(array, 20-1)]
    v = v ++ [Enum.at(array, 60-1)]
    v = v ++ [Enum.at(array,100-1)]
    v = v ++ [Enum.at(array,140-1)]
    v = v ++ [Enum.at(array,180-1)]
    v = v ++ [Enum.at(array,220-1)]
    v |> Enum.map(fn x -> get_value(x) end) |> Enum.sum()
  end
  def get_value({cycle,value}) do
    cycle * value
  end

  def execute(data) do
    execute(data, 2, 1, [{1,1}])
  end
  def execute([], _,_,array) do
    array
  end
  def execute(data, cycle, value, array) do
    command = Enum.at(data,0)
    cond do
      length(command) == 1 -> execute(Enum.drop(data,1), cycle+1, value, array ++ [{cycle,value}])
      length(command) == 2 -> execute(Enum.drop(data,1), cycle+2, value+String.to_integer(Enum.at(command,1)), array ++ [{cycle,value}, {cycle+1,value+String.to_integer(Enum.at(command,1))}])
      true -> throw("unknown command")
    end
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    execute(data) |> render() |> Enum.join() |>  String.codepoints |> Enum.take(40*6)|>Enum.chunk_every(40)|> Enum.map(&Enum.join/1)
    #runpath(Enum.map(0..10, fn _ -> {0,0} end),data)
    #|> Enum.count()
  end


  def render(chunk) do
    render(chunk, 0,[])
  end
  def render([], _, render) do
    render
  end
  def render(chunk, 40, render) do
    render(chunk, 0, render)
  end
  def render(chunk, clock, render) do
    value = elem(Enum.at(chunk,0),1)
    if Enum.member?(value-1..value+1, clock) do
      render(Enum.drop(chunk,1), clock+1, render ++ ["#"])
    else
      render(Enum.drop(chunk,1), clock+1, render ++ ["."])
    end
  end
end
