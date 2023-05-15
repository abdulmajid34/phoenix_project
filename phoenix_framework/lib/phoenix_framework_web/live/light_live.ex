defmodule PhoenixFrameworkWeb.LightLive do
  use PhoenixFrameworkWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, brightness: 10)
    {:ok, socket}
  end

  #render
  def render(assigns) do
    ~H"""
    <h1 class="text-center font-bold text-2xl my-4">Front Porch Light</h1>
      <div class="flex bg-gray-300 rounded">
        <span class="text-center bg-yellow-400 py-4 transition" style={"width: #{@brightness}%"}>
          <%= @brightness %>%
        </span>
      </div>
      <div class=" flex justify-center items-center my-4">
        <button
          class="mx-2 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          phx-click="off"
        >
          Off
        </button>
        <button
          class="mx-2 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          phx-click="up"
        >
          Up
        </button>
        <button
          class="mx-2 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          phx-click="down"
        >
          Down
        </button>
        <button
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          phx-click="on"
        >
          On
        </button>
      </div>

    """
  end

  # handle_event
  def handle_event("on", _, socket) do
    socket = assign(socket, brightness: 100)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &(&1 + 10))
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &(&1 - 10))
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, brightness: 0)
    {:noreply, socket}
  end
end
