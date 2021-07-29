defmodule ExplorandoMarte do
  @moduledoc """
  Documentation for `ExplorandoMarte`.
  """
  alias ExplorandoMarte.DirecaoCardinal
  alias ExplorandoMarte.MovimentaSonda

  def start(path) do
    case File.read(path) do
      {:ok, contents} ->
        [area | script] =
          contents
          |> String.split("\n", trim: true)

        area = String.split(area, " ")

        script
        |> Enum.chunk_every(2)
        |> Enum.map(fn comm ->
          script_sonda(area, Enum.at(comm, 0), Enum.at(comm, 1))
        end)
        |> salva_saida()

      {:error, :enoent} ->
        IO.puts("Erro ao abrir o arquivo")
    end
  end

  defp salva_saida(valor) do
    {:ok, file} = File.open("saida.txt", [:write])

    Enum.each(valor, fn linha ->
      IO.binwrite(file, linha <> "\n")
    end)

    File.close(file)
  end

  def script_sonda(area, posicao, comandos) do
    comandos = String.graphemes(comandos)

    processa_comando(area, posicao, comandos, length(comandos))
  end

  def processa_comando(area, posicao, comandos, count) when count > 0 do
    [comando | restante] = comandos

    cond do
      comando == "L" || comando == "R" ->
        processa_comando(
          area,
          DirecaoCardinal.muda_posicao(comando, posicao),
          restante,
          count - 1
        )

      comando == "M" ->
        processa_comando(area, MovimentaSonda.movimenta(posicao, area), restante, count - 1)

      true ->
        nil
    end
  end

  def processa_comando(_area, posicao, _comandos, _count), do: posicao
end
