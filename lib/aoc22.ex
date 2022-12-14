import Kernel

defmodule Aoc22 do
  @moduledoc """
  Module for solving all question in Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input.txt file.
  """
  def run_all do
    # clear result summery file
    File.rm("data/result_summery.txt")
    File.write("data/result_summery.txt", "Advent of Code 2022\r\n\r\n")
    solutions = [Aoc22d1, Aoc22d2, Aoc22d3, Aoc22d4, Aoc22d5, Aoc22d6, Aoc22d7, Aoc22d8,
                 Aoc22d9, Aoc22d10, Aoc22d11]
    Enum.map(0..(length(solutions)-1), fn i -> run_day(i+1,Enum.at(solutions,i)) end)
  end

  def run_day(n,x) do
    start = :os.system_time(:millisecond)
    data = x.data()
    timeData = :os.system_time(:millisecond)-start
    run_day(n,x,data,timeData)
  end

  def run_day(n,x,file) do
    start = :os.system_time(:millisecond)
    data = x.data(file)
    timeData = :os.system_time(:millisecond)-start
    run_day(n,x,data,timeData)
  end

  def run_day(n,x,data,data_time) do
    start = :os.system_time(:millisecond)
    q1 = x.question1(data)
    timeQ1 = :os.system_time(:millisecond)-start
    start = :os.system_time(:millisecond)
    q2 = x.question2(data)
    timeQ2 = :os.system_time(:millisecond)-start
    str = "Result day #{n}:\t-question 1 [#{timeQ1}ms]: [#{q1}]\t-question 2 [#{timeQ2}ms]: [#{q2}]\t-data format time: [#{data_time}ms]"
    IO.puts(str)
    File.write("data/result_summery.txt", Enum.join([str,"\r\n"]), [:append])
  end
end
