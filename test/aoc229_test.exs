defmodule Aoc22d9Test do
  use ExUnit.Case
  doctest Aoc22d9

  test "example 1 for question 1" do
    assert Aoc22d9.question1(Aoc22d9.data("data/test/day9_1.txt")) == 13
  end

  test "input result question 1" do
    IO.puts("day 9 question 1: [#{Aoc22d9.question1(Aoc22d9.data("data/input/day9.txt"))}]")
    assert true
  end

  test "example 2 for question 2" do
    assert Aoc22d9.question2(Aoc22d9.data("data/test/day9_2.txt")) == 36
  end

  test "input result question 2" do
    IO.puts("day 9 question 2: [#{Aoc22d9.question2(Aoc22d9.data("data/input/day9.txt"))}]")
    assert true
  end
end
