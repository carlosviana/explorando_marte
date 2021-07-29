defmodule ExplorandoMarteTest do
  use ExUnit.Case
  doctest ExplorandoMarte

  alias ExplorandoMarte.DirecaoCardinal

  test "funcao de start do input" do
    File.rm("saida.txt")

    ExplorandoMarte.start("entrada.txt")

    assert File.exists?("saida.txt")
  end

  test "mudando de posicao no script" do
    assert ExplorandoMarte.script_sonda([5, 5], "1 2 N", "L") == "1 2 W"
  end

  test "movimento unico dentro do script" do
    assert ExplorandoMarte.script_sonda([5, 5], "1 2 W", "M") == "0 2 W"
  end

  test "movimentos completos" do
    assert ExplorandoMarte.script_sonda([5, 5], "1 2 N", "LMLMLMLMM") == "1 3 N"
    assert ExplorandoMarte.script_sonda([5, 5], "3 3 E", "MMRMMRMRRM") == "5 1 E"
  end

  test "movimentos completos fora da área" do
    assert ExplorandoMarte.script_sonda([5, 5], "3 4 S", "RRMM") == "3 5 N"
    assert ExplorandoMarte.script_sonda([5, 5], "1 2 N", "LMMLMM") == "0 0 S"
  end

  test "movimentos complexo" do
    assert ExplorandoMarte.script_sonda([5, 5], "3 3 E", "LMMLMRMMMLMRMRMMRRMM") == "1 5 W"
  end

  test "mudando posicao" do
    assert DirecaoCardinal.muda_posicao("L", "N") == "W"
    assert DirecaoCardinal.muda_posicao("R", "N") == "E"
    assert DirecaoCardinal.muda_posicao("L", "S") == "E"
    assert DirecaoCardinal.muda_posicao("R", "S") == "W"
    assert DirecaoCardinal.muda_posicao("L", "E") == "N"
    assert DirecaoCardinal.muda_posicao("R", "E") == "S"
    assert DirecaoCardinal.muda_posicao("L", "W") == "S"
    assert DirecaoCardinal.muda_posicao("R", "W") == "N"
  end
end
