defmodule Aoc22 do
  @moduledoc """
  Module for solving all question in Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input.txt file.
  """
  def runAll do
    runDay(1,Aoc22d1)
    runDay(2,Aoc22d2)
  end

  def runDay(n,x) do
    IO.puts("Result day #{n}: -answer1 [#{x.question1()}] -answer2 [#{x.question2()}]")
  end
end
