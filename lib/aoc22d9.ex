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
    runpath(Enum.map(0..1, fn _ -> {0,0} end),data)
    |> Enum.count()
  end
  def runpath(tail,data) do
    runpath(tail,data,%{{0,0} => true})
  end
  def runpath(tail,[],  map) do
    updatmap(map, Enum.at(tail,-1))
  end
  def runpath(tail,data,  map) do

    Enum.at(data, 0)
    |> execute(tail)
    |> runpath(Enum.drop(data,1), updatmap(map, Enum.at(tail,-1)))
  end

  def execute(cmd, tail) do
    pos = Enum.at(tail,0)
    case cmd do
      "U" -> get_new_tail(Enum.drop(tail,1), tuple_add(pos,{1,0}))
      "D" -> get_new_tail(Enum.drop(tail,1), tuple_add(pos,{-1,0}))
      "L" -> get_new_tail(Enum.drop(tail,1), tuple_add(pos,{0,-1}))
      "R" -> get_new_tail(Enum.drop(tail,1), tuple_add(pos,{0,1}))
      _ -> throw("unknown command")
    end
  end

  def get_new_tail(tail, pos) do
    get_new_tail(tail, pos,[pos])
  end
  def get_new_tail([], _, newtail) do
    newtail
  end
  def get_new_tail(tail, head, newtail) do
    if tuple_distance(head,Enum.at(tail,0))<2 do
      newtail++tail
    else
      new_tail_pos = get_new_tail_pos(Enum.at(tail,0),head)
      get_new_tail(Enum.drop(tail,1), new_tail_pos, newtail ++ [new_tail_pos])
    end
  end

  def get_new_tail_pos(tail, pos) do
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
    runpath(Enum.map(0..9, fn _ -> {0,0} end),data)
    |> Enum.count()
  end



  def is_in_map(_,_ ,{0,0}) do
    's'
  end
  def is_in_map(map, map2, pos) do

    if Map.has_key?(map, tuple_add( pos,{0.0,0.0})) do
      if Map.has_key?(map2, tuple_add( pos,{0.0,0.0})) do
        '#'
      else
        '.'
      end
    else
      if Map.has_key?(map2, tuple_add( pos,{0.0,0.0})) do
        'O'
      else
        ' '
      end
    end
  end

  def art() do
    data= data()
    map1 = runpath(Enum.map(0..1, fn _ -> {0,0} end),data)
    map2 = runpath(Enum.map(0..9, fn _ -> {0,0} end),data)

    keys = Map.keys(map1) ++ Map.keys(map2)
    #IO.inspect(keys)
    max_x = round(elem(Enum.max_by( keys, fn {x,_} -> x end),0))
    max_y = round(elem(Enum.max_by( keys, fn {_,y} -> y end),1))
    min_x = round(elem(Enum.min_by( keys, fn {x,_} -> x end),0))
    min_y = round(elem(Enum.min_by( keys, fn {_,y} -> y end),1))

    result= Enum.map(min_x..max_x, fn x -> Enum.map(min_y..max_y, fn y-> is_in_map(map1, map2, {x,y}) end ) end)
    |> Enum.map(fn x -> Enum.join(x) end)
    |> Enum.join("\r\n")
    # write to file
    File.write("data/output/day9.txt", result)
  end
end
