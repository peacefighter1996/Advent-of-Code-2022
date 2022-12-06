import Kernel

defmodule Aoc22 do
  @moduledoc """
  Module for solving all question in Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input.txt file.
  """
  def runAll do
    # clear result summery file
    File.rm("data/result_summery.txt")
    File.write("data/result_summery.txt", "Advent of Code 2022\r\n\r\n")
    solutions = [Aoc22d1, Aoc22d2, Aoc22d3, Aoc22d4, Aoc22d5, Aoc22d6]
    Enum.map(0..(length(solutions)-1), fn i -> runDay(i+1,Enum.at(solutions,i)) end)
  end

  def runDay(n,x) do
    start = :os.system_time(:millisecond)
    data = x.data()
    timeData = :os.system_time(:millisecond)-start
    start = :os.system_time(:millisecond)
    q1 = x.question1(data)
    timeQ1 = :os.system_time(:millisecond)-start
    start = :os.system_time(:millisecond)
    q2 = x.question2(data)
    timeQ2 = :os.system_time(:millisecond)-start
    str = "Result day #{n}:\t-question 1 [#{timeQ1}ms]: [#{q1}]\t-question 2 [#{timeQ2}ms]: [#{q2}]\t-data format time: [#{timeData}ms]"
    IO.puts(str)
    File.write("data/result_summery.txt", Enum.join([str,"\r\n"]), [:append])
  end

  def runDay(n,x,file) do
    start = :os.system_time(:millisecond)
    data = x.data(file)
    timeData = :os.system_time(:millisecond)-start
    IO.puts("Retrieved data from file: #{file}")
    start = :os.system_time(:millisecond)
    q1 = x.question1(data)
    timeQ1 = :os.system_time(:millisecond)-start
    IO.puts("Question 1 done")
    start = :os.system_time(:millisecond)
    q2 = x.question2(data)
    timeQ2 = :os.system_time(:millisecond)-start
    IO.puts("Question 2 done")
    str = "Result day #{n}:\t-question 1 [#{timeQ1}ms]: [#{q1}]\t-question 2 [#{timeQ2}ms]: [#{q2}]\t-data format time: [#{timeData}ms]"
    IO.puts(str)
    File.write("data/result_summery.txt", Enum.join([str,"\r\n"]), [:append])
  end
end
