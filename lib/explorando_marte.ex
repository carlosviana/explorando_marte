defmodule ExplorandoMarte do
  @moduledoc """
  Documentation for `ExplorandoMarte`.
  """
  alias ExplorandoMarte.DirecaoCardinal

  def script_sonda(area, posicao, comandos) do

    proc = String.graphemes(comandos)
    |> Enum.each(fn comando ->
      processa_comando(area, posicao, comando)
    end)


    IO.inspect(proc)

  end

  def processa_comando(area, posicao, comando) do
    com = cond do
      comando == "L" || comando == "R" ->
        muda_posicao(comando, posicao)

      comando == "M" ->
        movimenta(posicao, area)

      true ->
        comando
    end

    com
  end

  def muda_posicao(comando, posicao) do
    nova_posicao =
      posicao
      |> String.graphemes()
      |> Enum.reverse()
      |> hd()
      |> DirecaoCardinal.get(comando)

    posicao
    |> String.graphemes()
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
    |> Enum.concat([nova_posicao])
    |> List.to_string()
  end

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
