defmodule Exdb do
    use Application

    @doc false
    def start(_type, _args) do
        import Supervisor.Spec

        #Exdb.Server.start_link()

        children =
            [
                supervisor(Task.Supervisor, [[name: Exdb.TaskSupervisor]]),
                worker(Task, [Exdb, :accept, [4040]])
            ]

        opts = [strategy: :one_for_one, name: Exdb.Supervisor]
        Supervisor.start_link(children, opts)
    end

    def accept(port) do
        case :gen_tcp.listen(port, [:binary, packet: :line, active: false]) do
            {:ok, socket} ->
                case IO.puts "listening on port #{port}\n" do
                    _ -> loop_acceptor(socket)
                end
            {:error, _} -> IO.puts "unable to listen on port #{port}\n"
        end
    end

    defp loop_acceptor(socket) do
        case :gen_tcp.accept(socket) do
            {:ok, client} -> Task.Supervisor.start_child(Exdb.TaskSupervisor, fn -> serve(client) end)
            {:error, :closed} -> {:error, "error while reading socket: socket was closed\n"}
            {:error, _} -> IO.puts "unable to accept client on socket\n"
        end

        loop_acceptor(socket)
    end

    defp serve(socket) do
        {status, msg} =
            case :gen_tcp.recv(socket, 0) do
                {:ok, line} -> {:ok, "received msg: #{line}\n"}
                {:error, :closed} -> {:error, "error while reading socket: socket was closed\n"}
                {:error, _} -> {:error, "error while reading socket\n"}
            end

        :gen_tcp.send(socket, msg)
        serve(socket)
    end
end
