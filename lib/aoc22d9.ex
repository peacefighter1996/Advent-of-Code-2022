defmodule Aoc22d9 do
  @moduledoc """
  Module for solving the questions of day 9 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/input/day9.txt")
  end

  @spec data(String.t()) :: list(String.t())
  def data(file) do
    {:ok, data} = File.read(file)
    String.split(data, "\r\n")
    |> Enum.map(fn x -> String.split(x," ") end)
    |> Enum.map(fn [x,y] -> Enum.map(1..String.to_integer(y), fn _-> x end) end)
    |> Enum.flat_map(fn x-> x end)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    map = %{{0,0} => true}
    runpath(data, {0,0}, Enum.map(1..1, fn _ -> {0,0} end), map)
    |> Enum.count()
  end


  def runpath([], _, _, map) do
    map
  end
  def runpath(data, pos, tail, map) do
    cmd = Enum.at(data, 0)
    case cmd do
      "U" -> updateTail(Enum.drop(data,1), tuple_add(pos,{1,0}), tail, map)
      "D" -> updateTail(Enum.drop(data,1), tuple_add(pos,{-1,0}), tail, map)
      "L" -> updateTail(Enum.drop(data,1), tuple_add(pos,{0,-1}), tail, map)
      "R" -> updateTail(Enum.drop(data,1), tuple_add(pos,{0,1}), tail, map)
      _ -> throw("unknown command")
    end
  end

  def updateTail(data, pos, tail, map) do
    newtail=get_new_tail(tail, pos, [])
    #IO.inspect(newtail)
    runpath(data, pos, newtail, updatmap(map, Enum.at(newtail,-1)))
  end
  def get_new_tail([], _, newtail) do
    newtail
  end
  def get_new_tail(tail, head, newtail) do
    if tuple_distance(head,Enum.at(tail,0))<2 do
      newtail++tail
    else
      new_tail_pos = get_new_tail(Enum.at(tail,0),head)
      get_new_tail(Enum.drop(tail,1), new_tail_pos, newtail ++ [new_tail_pos])
    end
  end

  def get_new_tail(tail, pos) do
    diffrence = tuple_sub(pos,tail)
    pos_x = elem(diffrence,0) / Enum.max([abs(elem(diffrence,0)),1])
    pos_y = elem(diffrence,1) / Enum.max([abs(elem(diffrence,1)),1])
    tuple_add(tail, {pos_x, pos_y})
  end

  def tuple_add({x1,y1},{x2,y2}) do
    {x1+x2,y1+y2}
  end

  def tuple_sub({x1,y1},{x2,y2}) do
    {x1-x2,y1-y2}
  end

  def tuple_distance({x1,y1},{x2,y2}) do
    :math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
  end

  def updatmap(map, pos) do
    #IO.inspect(pos)
    if Map.has_key?(map, pos) do
      map
    else
      Map.put(map, pos, true)
    end
  end


  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    runpath(data, {0,0}, Enum.map(1..9, fn _ -> {0,0} end), %{{0,0} => true})
    |> Enum.count()
  end


end
