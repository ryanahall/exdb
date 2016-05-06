defmodule Exdb do
  use Application
  require Logger

  @port 4040

  @doc false
  def start(_type, _args) do
    import Supervisor.Spec

    #Exdb.Server.start_link()

    Logger.info "Starting ExDB"

    children =
      [
        supervisor(Task.Supervisor, [[name: Exdb.TaskSupervisor]]),
        worker(Task, [Exdb, :accept, [@port]])
      ]

    opts = [strategy: :one_for_one, name: Exdb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def accept(port) do
    case :gen_tcp.listen(port, [:binary, packet: :line, active: false]) do
      {:ok, socket} ->
        case Logger.info "Listening on port #{port}" do
          _ -> loop_acceptor(socket)
        end
      {:error, _} -> Logger.error "Unable to listen on port #{port}\n"
    end
  end

  defp loop_acceptor(socket) do
    case :gen_tcp.accept(socket) do
      {:ok, client} ->
        case :inet.peername(client) do
            {:ok, {host, port}} ->
              addr = :inet_parse.ntoa(host) |> List.to_string
              Logger.info "Accepted connection from host #{addr}:#{port}"
              Task.Supervisor.start_child(Exdb.TaskSupervisor, fn -> serve(client) end)
            {:error, _} -> Logger.error "Unable to determine peername"
        end
      {:error, :closed} -> Logger.error "Error while reading socket: socket was closed"
      {:error, _} -> Logger.error "Unable to accept client on socket"
    end

    loop_acceptor(socket)
  end

  defp serve(socket) do
    result =
      case :gen_tcp.recv(socket, 0) do
        {:ok, line} -> {:ok, "received msg: #{line}\n"}
        {:error, reason} -> {:error, reason}
      end

    case result do
      {:ok, msg} ->
         :gen_tcp.send(socket, msg)
         serve(socket)
      {:error, :closed} -> Logger.info "Closed connection from host"
      {:error, reason} -> serve(socket)
    end
  end
end
