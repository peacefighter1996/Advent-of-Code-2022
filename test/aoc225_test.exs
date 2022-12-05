defmodule Aoc22d5Test do
  use ExUnit.Case
  doctest Aoc22d5

  test "example 1 for question 1" do
    assert Aoc22d5.question1(Aoc22d5.data("data/test/day5_1.txt")) == 'CMZ'
  end

  test "input result question 1" do
    IO.puts("day 5 question 1: [#{Aoc22d5.question1(Aoc22d5.data("data/input/day5.txt"))}]")
    assert true
  end

  test "input result question 2" do
    IO.puts("day 5 question 2: [#{Aoc22d5.question2(Aoc22d5.data("data/input/day5.txt"))}]")
    assert true
  end

  test "example 1 for question 2" do
    assert Aoc22d5.question2(Aoc22d5.data("data/test/day5_1.txt")) == 'MCD'
  end
end
