defmodule HelloLiveViewWeb.TextComponents do
  use Phoenix.Component

  def page_title(assigns) do
    ~H"""
    <header class="bg-white shadow">
      <div class="mx-auto max-w-7xl py-4 px-4 sm:px-4 lg:px-8">
        <h1 class="text-3xl font-bold tracking-tight text-gray-900">{@title}</h1>
      </div>
    </header>
    """
  end

  def body(assigns) do
    ~H"""
    <div class="mx-auto max-w-7xl py-2 sm:px-6 lg:px-8">
      {render_slot(@inner_block)}
    </div>
    """
  end

  def link_to(assigns) do
    ~H"""
    <a href={@href} class="text-indigo-600 hover:text-indigo-900">{render_slot(@inner_block)}</a>
    """
  end
end
