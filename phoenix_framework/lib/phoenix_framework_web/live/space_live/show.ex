defmodule PhoenixFrameworkWeb.SpaceLive.Show do
  use PhoenixFrameworkWeb, :live_view

  alias PhoenixFramework.Worlds

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:space, Worlds.get_space!(id))}
  end

  defp page_title(:show), do: "Show Space"
  defp page_title(:edit), do: "Edit Space"
end
