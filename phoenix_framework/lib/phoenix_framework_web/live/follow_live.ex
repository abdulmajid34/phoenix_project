defmodule PhoenixFrameworkWeb.FollowLive do
  use PhoenixFrameworkWeb, :live_view

  def mount(_params, _session, socket) do
    Process.sleep(300)
    {:ok, socket |> follow({:mount, connected?(socket)})}
  end

  defp follow(socket, data) do
    follows = Map.get(socket.assigns, :follows) || []
    assign(socket, follows: [data|follows])
  end

  def render(assigns) do
    ~H"""
    <h1>hello world</h1>
    <pre>
    <%= @follows |> Enum.reverse |> inspect %>
    </pre>

    <.link href={~p"/follow"}>Link</.link>
    <.link patch={~p"/follow"}>Patch</.link>
    <.link navigate={~p"/follow"}>Redirect</.link>
    """
  end

  def handle_params(_, _url, socket) do
    {:noreply, socket |> follow({:handle_params, connected?(socket)})}
  end
end
