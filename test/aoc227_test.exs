defmodule Aoc22d7Test do
  use ExUnit.Case
  doctest Aoc22d7

  test "example 1 for question 1" do
    assert Aoc22d7.question1(Aoc22d7.data("data/test/day7_1.txt")) == 95437
  end

  #test "input result question 1" do
  #  IO.puts("day 7 question 1: [#{Aoc22d7.question1(Aoc22d7.data("data/input/day7.txt"))}]")
  #  assert true
  #end
##
  #test "input result question 2" do
  #  IO.puts("day 7 question 2: [#{Aoc22d7.question2(Aoc22d7.data("data/input/day7.txt"))}]")
  #  assert true
  #end
##
  #test "example 1 for question 2" do
  #  assert Aoc22d7.question2('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 19
  #end
end
