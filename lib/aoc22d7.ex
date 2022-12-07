defmodule Aoc22d7 do
  @moduledoc """
  Module for solving the questions of day 5 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/input/day7.txt")
  end

  @spec data(String.t()) :: list(String.t())
  def data(file) do
    {:ok, data} = File.read(file)
    String.split(data, "\r\n")
    |> Enum.drop(1)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    execute(data,["c"],%{})
    #|> Map.values()
    #|> Enum.filter(fn x -> x < 100_000 end)
    #|> Enum.sum()
  end

  def execute([], _, dataset) do
    dataset
  end
  def execute(data, path, dataset) do
    log = data |> Enum.at(0)
    IO.puts([[path]])
    cond do
      String.starts_with?(log,"$") -> execute_command(log, data, path, dataset)
      String.starts_with?(log,"dir") -> execute(Enum.drop(data,1), path, dataset)
      true -> execute( Enum.drop(data,1), path, update_dataset( log, path ,dataset))
    end
  end


  def update_dataset(log, path ,dataset) do
    log = String.split(log," ")
    key = path |> Enum.join("/")
    if Map.has_key?(dataset, key) do
      {:ok,value} = Map.fetch(dataset, key)
      new_value = value + String.to_integer((log |> Enum.at(0)))
      Map.delete(dataset, key)
      |>  Map.put(key, new_value)
    else
      Map.put(dataset, key, log |> Enum.at(0) |> String.to_integer())
    end
  end

  def execute_command(log, data, path, dataset) do
    IO.puts(length(path))
    cond do
      String.contains?(log, "cd ..") -> execute(Enum.drop(data,1),Enum.take(path,length(path)-1), dataset)
      String.contains?(log, "cd") ->
        execute(Enum.drop(data,1), [path]++[Enum.at(String.split(log," "),2)], dataset)
      String.contains?(log, "ls") ->
          execute(Enum.drop(data,1), path, dataset)
      true -> throw "unknown command"
    end
  end


  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    data
  end


end
