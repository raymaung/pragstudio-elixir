defmodule Servy.KickStarter do

  use GenServer

  defmodule State do
    defstruct http_server_pid: nil
  end

  def start_link(_args) do
    IO.puts "Starting the kick starter"
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get_server do
    GenServer.call(__MODULE__, :get_server)
  end

  def init(_state) do
    Process.flag(:trap_exit, true)
    new_state = start_http_server()
    {:ok, new_state}
  end

  def handle_info({:EXIT, _pid, reason}, _state) do
    IO.puts("HttpServer exited (#{inspect reason}")
    new_state = start_http_server()
    {:noreply, new_state}
  end

  def handle_info(unexpected, state) do
    IO.puts "Can't touch this! #{inspect unexpected}"
    {:noreply, state}
  end

  def handle_call(:get_server, _from, state) do
    {:reply, state.http_server_pid, state}
  end

  defp start_http_server() do
    IO.puts "Starting the HTTP Server"
    port = Application.get_env(:servy, :port)
    server_pid = spawn(Servy.HttpServer, :start, [port])
    Process.link(server_pid)
    Process.register(server_pid, :http_server)
    %State{http_server_pid: server_pid}
  end
end
