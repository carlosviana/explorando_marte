defmodule ExplorandoMarte.DirecaoCardinal do
  def get(posicao, comando) do
    direcoes = ["N", "E", "S", "W"]

    pos = Enum.find_index(direcoes, fn x -> x == posicao end)

    pos =
      cond do
        comando == "R" -> pos + 1
        comando == "L" -> pos - 1
        true -> pos
      end

    pos =
      cond do
        pos == -1 -> 3
        pos == 4 -> 0
        true -> pos
      end

    Enum.at(direcoes, pos)
  end
end
