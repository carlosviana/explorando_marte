defmodule ExplorandoMarte.DirecaoCardinal do
  # REFACTORY
  def get(posicao, comando) do
    cond do
      posicao == "N" && comando == "L" -> "W"
      posicao == "N" && comando == "R" -> "E"
      posicao == "S" && comando == "L" -> "E"
      posicao == "S" && comando == "R" -> "W"
      posicao == "E" && comando == "L" -> "N"
      posicao == "E" && comando == "R" -> "S"
      posicao == "W" && comando == "L" -> "S"
      posicao == "W" && comando == "R" -> "N"
      true -> nil
    end
  end
end
