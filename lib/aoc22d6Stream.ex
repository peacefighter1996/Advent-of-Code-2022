defmodule Aoc22d6Stream do
  @moduledoc """
  Module for solving the questions of day 5 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day5.txt file.
  """
  def data do
    data("data/extra_challange/day6xxl.txt")
  end

  @spec data(String.t()) :: list(integer)
  def data(file) do
    file
  end

  def question1() do
    question1(data())
  end
  def question1(file) do
    fs = File.stream!(file,[:read],1_000_000)
    mask = Enum.take(fs,1)
    |> Enum.at(0)
    |> String.to_charlist() |> Enum.take(4)
    Aoc22d6.initmask(mask)
    |> find_index(mask, [], fs ,4,false)
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

  def checkBuffer(fs) do
    IO.puts(Enum.take(fs,1)|> Enum.at(0))
    temp = Enum.take(fs,1)|> Enum.at(0) |> String.to_charlist()
    {temp ,Stream.drop(fs,1)}
  end

  def find_index(maskmap,mask,[],fs,i, true) do
    {newBuffer,fsk} = checkBuffer(fs)
    find_index(maskmap,mask,newBuffer,fsk,i,length(Map.keys(maskmap)) == length(mask))
  end
  def find_index(_,_,_,_, i, true) do
    i
  end
  def find_index(maskmap,mask,buffer,fs,i,false) do
    k = Enum.at(buffer,0)
    maskmap
    |> Aoc22d6.decrease(Enum.at(mask,0))
    |> Aoc22d6.increase(k)
    |> find_index(Enum.drop(mask,1) ++[k], Enum.drop(buffer,1),fs,i+1,length(Map.keys(maskmap)) == length(mask))
  end
end
