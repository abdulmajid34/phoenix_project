defmodule PhoenixFrameworkWeb.MyComponent do
  use Phoenix.Component

  def greet(assigns) do
    ~H"""
    <h1 class=" text-lg pl-8">Hello,<%= @name %></h1>
    """
  end
end
