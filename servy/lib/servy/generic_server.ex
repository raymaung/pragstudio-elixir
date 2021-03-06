defmodule  Servy.GenericServer do

  def start(callback_module, initial_state, name) do
    pid = spawn(__MODULE__, :listen_loop, [callback_module, initial_state])
    Process.register(pid, name)
    pid
  end

  def call(pid, message) do
    send(pid, {:call, self(), message})
    receive do {:response, response} -> response end
  end

  def cast(pid, message) do
    send(pid, {:cast, message})
  end

  # Server
  def listen_loop(callback_module, state) do
    receive do
      {:call, sender, message} when is_pid(sender) ->
        {response, new_state} = callback_module.handle_call(message, state)
        send sender, {:response, response}
        listen_loop(callback_module, new_state)

      {:cast, message} ->
        new_state = callback_module.handle_cast(message, state)
        listen_loop(callback_module, new_state)

      unexpected ->
        IO.puts "Unexpected messaged: #{inspect unexpected}"
        listen_loop(callback_module, state)
    end
  end
end