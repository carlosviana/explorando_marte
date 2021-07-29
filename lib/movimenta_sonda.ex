defmodule ExplorandoMarte.MovimentaSonda do
  def movimenta(posicao, area) do
    pos = String.split(posicao)

    area = %{:x => Enum.at(area, 0), :y => Enum.at(area, 0)}

    pos = %{
      :x => Enum.at(pos, 0) |> String.to_integer(),
      :y => Enum.at(pos, 1) |> String.to_integer(),
      :direcao => Enum.at(pos, 2)
    }

    xs =
      cond do
        pos[:direcao] == "W" && pos[:x] > 0 ->
          %{pos | :x => pos[:x] - 1}

        pos[:direcao] == "E" && pos[:x] < area[:x] ->
          %{pos | :x => pos[:x] + 1}

        pos[:direcao] == "N" && pos[:y] < area[:y] ->
          %{pos | :y => pos[:y] + 1}

        pos[:direcao] == "S" && pos[:y] > 0 ->
          %{pos | :y => pos[:y] - 1}

        true ->
          pos
      end

    x = xs[:x] |> Integer.to_string()
    y = xs[:y] |> Integer.to_string()
    dir = xs[:direcao]

    x <> " " <> y <> " " <> dir
  end
end
