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
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    execute(data,[],%{})
    |> Map.values()
    |> Enum.filter(fn x -> x < 100_000 end)
    |> Enum.sum()
  end

  def execute([], [], dataset) do
    dataset
  end
  def execute([], path, dataset) do
    execute( [],Enum.take(path,length(path)-1),add_to_root(path,dataset))
  end
  def execute(data, path, dataset) do
    log = data |> Enum.at(0)
    #IO.puts([[path]])
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

  def add_to_root(path,dataset) do
    base_key = Enum.take(path, length(path)-1)|> Enum.join("/")
    key = path |> Enum.join("/")
    {:ok,value_base} = Map.fetch(dataset, key)
    if Map.has_key?(dataset, base_key) do
      {:ok,value} = Map.fetch(dataset, base_key)
      new_value = value_base + value
      Map.delete(dataset, path)
      |>  Map.put(base_key, new_value)
    else
      Map.put(dataset, base_key, value_base)
    end
  end

  def execute_command(log, data, path, dataset) do
    #IO.inspect path, char_lists: :as_list
    cond do
      String.contains?(log, "cd ..") -> execute(Enum.drop(data,1),Enum.take(path,length(path)-1), add_to_root(path, dataset))
      String.contains?(log, "cd") ->
        execute(Enum.drop(data,1), path++[Enum.at(String.split(log," "),2)],dataset )
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
    map = execute(data,[],%{})
    temp = map
    |> Map.values()
    |> Enum.sort()
    {:ok,current_size} = Map.fetch(map, "/")
    find_smallest(70_000_000, 30_000_000,current_size, temp)
  end

  def find_smallest(drive_size, requested, current_size, folders) do
    value = (drive_size - current_size + Enum.at(folders, 0))
    #IO.puts(value)
    if value < requested do
      find_smallest(drive_size, requested, current_size, Enum.drop(folders,1))
    else
      Enum.at(folders, 0)
    end
  end




end
