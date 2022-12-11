defmodule Aoc22d10Test do
  use ExUnit.Case
  doctest Aoc22d10

  test "example 1 for question 1" do
    assert Aoc22d10.question1(Aoc22d10.data("data/test/day10_1.txt")) == 13140
  end

  test "input result question 1" do
    IO.puts("day 10 question 1: [#{Aoc22d10.question1(Aoc22d10.data("data/input/day10.txt"))}]")
    assert true
  end

  test "example 1 for question 2" do
    assert Aoc22d10.question2(Aoc22d10.data("data/test/day10_1.txt"))  ==
      ["##..##..##..##..##..##..##..##..##..##..",
       "###...###...###...###...###...###...###.",
       "####....####....####....####....####....",
       "#####.....#####.....#####.....#####.....",
       "######......######......######......####",
       "#######.......#######.......#######....."]
  end

  test "input result question 2" do
    IO.puts("day 10 question 2:")
    IO.inspect(Aoc22d10.question2(Aoc22d10.data("data/input/day10.txt")))
    assert true
  end
end
