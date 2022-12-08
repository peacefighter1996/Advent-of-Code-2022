defmodule Aoc22d8 do
  @moduledoc """
  Module for solving the questions of day 7 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/input/day8.txt")
  end

  @spec data(String.t()) :: list(String.t())
  def data(file) do
    {:ok, data} = File.read(file)
    String.split(data, "\r\n")
    |> Enum.map(fn x -> x
                |> String.splitter("", trim: true)
                |> Enum.map(&String.to_integer/1) end)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do

    m1 =process_map(data)
    m2 =transpose(data)
    |> process_map()
    |> Enum.map(fn x-> transpose(x)end)
    #IO.puts "m1: #{m1}"
    #IO.puts "m2: #{m2}"
    l = length(data)
    (l*l) - (combine(m1, m2)|> Enum.flat_map(fn x-> x end) |> Enum.filter(fn x-> x==0 end) |> Enum.count())
  end
  @spec process_map(list(list(integer))) :: list(list(list(boolean)))
  def process_map(data)do
    current = self()
    Enum.map(data,fn x-> spawn_link(fn -> send(current, {self(), walk_row(x,-1, [])}) end)end) ++ Enum.map(data,fn x-> spawn_link(fn -> send(current, {self(), Enum.reverse(walk_row(Enum.reverse(x),-1, []))}) end)end)
    |> Enum.map(fn child -> receive do
      {^child, k} -> k
    end end)
    |> Enum.chunk_every(length(data))

  end


  def walk_row([], _ , record) do
    record
  end
  def walk_row(row, 9 , record) do
    record++Enum.map(0..length(row)-1, fn _-> false end)
  end
  def walk_row(row, weight, record) do
    walk_row(Enum.drop(row,1), Enum.max([weight,Enum.at(row,0)]), record++[Enum.at(row,0)>weight])
  end
  def transpose(rows) do
    rows
    |> List.zip
    |> Enum.map(&Tuple.to_list/1)
  end
  def combine([m1,m2], [m3,m4]) do
    Enum.map(0..length(m1)-1, fn x -> Enum.map(0..length(m2)-1,fn y-> get(x,y,[m1,m2,m3,m4]) end) end)
  end
  def get(x,y,maps) do
    Enum.map(maps, fn m -> Enum.at(Enum.at(m,x),y) end)
    |> Enum.filter(fn x-> x end)
    |> Enum.count()
  end

  @doc """
  combine 2 maps item by item and return a new map
  """
  def combine([m1,m2]) do
    Enum.map(m1, fn x -> Enum.zip(x,m2) end)
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    m1 =process_map(data)
    m2 =transpose(data)
    |> process_map()
    |> Enum.map(fn x-> transpose(x)end)
    #IO.puts "m1: #{m1}"
    #IO.puts "m2: #{m2}"
    combine(m1, m2)|> find_spots() |> get_scenic_scores(data) |> Enum.max()
  end

  # find alls the locations where the map is not 0
  def find_spots(m) do
    Enum.map(0..length(m)-1, fn x -> Enum.map(0..length(m)-1,fn y-> if Enum.at(Enum.at(m,x),y)>0 do {x,y} else nil end end) end)
    |> Enum.flat_map(fn x-> x end)
    |> Enum.filter(fn x-> x != nil end)
  end

  def get_scenic_scores(location, data)do
    #current = self()
    transposed = transpose(data)
    Enum.map(location,fn {x,y}-> get_scenic_score(Enum.at(data,x),Enum.at(transposed,y), x,y,Enum.at(Enum.at(data,x),y)) end)
  end
  def get_scenic_score([], _,value) do
    value
  end
  def get_scenic_score(row, height,value) do
    #IO.inspect {row, height, value}
    if Enum.at(row,0) < height do
      get_scenic_score(Enum.drop(row,1), height, value+1)
    else
      value+1
    end
  end
  def get_scenic_score(row,column, x,y,v) do

    l = length(row)

    score1 = get_scenic_score(Enum.drop(row,y+1), v, 0)
    score2 = get_scenic_score(Enum.drop(column,x+1), v, 0)
    score3 = get_scenic_score(Enum.drop(Enum.reverse(row),l-y), v, 0)
    score4 = get_scenic_score(Enum.drop(Enum.reverse(column),l-x), v, 0)

    #IO.inspect {self(),x,y, row,  column, score1*score2*score3*score4 }

    score1*score2*score3*score4
    #
    #

  end
end
