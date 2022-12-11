defmodule Aoc22d8Test do
  use ExUnit.Case
  doctest Aoc22d8

  test "example 1 for question 1" do
    assert Aoc22d8.question1(Aoc22d8.data("data/test/day8_1.txt")) == 21
  end

  test "input result question 1" do
    IO.puts("day 8 question 1: [#{Aoc22d8.question1(Aoc22d8.data("data/input/day8.txt"))}]")
    assert true
  end

  test "example 1 for question 2" do
    assert Aoc22d8.question2(Aoc22d8.data("data/test/day8_1.txt")) == 8
  end

  test "input result question 2" do
    IO.puts("day 8 question 2: [#{Aoc22d8.question2(Aoc22d8.data("data/input/day8.txt"))}]")
    assert true
  end


end
