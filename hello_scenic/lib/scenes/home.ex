defmodule HelloScenic.Scene.Home do
  use Scenic.Scene
  alias Scenic.Graph
  import Scenic.Primitives
  import Scenic.Clock.Components

  @graph Graph.build(font: :roboto, font_size: 15)
         |> circle(30, fill: :red, stroke: {6, :yellow}, t: {40, 60})
         |> ellipse({30, 40}, fill: :green, stroke: {4, :gray}, t: {110, 60})
         |> text("Hello", t: {15, 150}, font: :roboto, font_size: 50)
         |> text("World", t: {15, 190}, fill: :purple, font: :roboto_mono, font_size: 30)
         |> analog_clock(seconds: true, radius: 80, ticks: true, t: {230, 100})
         |> text("", id: :event, t: {0, 220})

  @impl Scenic.Scene
  def init(scene, _param, _opts) do
    scene = push_graph(scene, @graph)
    :ok = request_input(scene, [:cursor_pos, :cursor_scroll, :cursor_button])
    {:ok, scene}
  end

  @impl Scenic.Scene
  def handle_input(event, _context, scene) do
    graph =
      @graph
      |> Graph.modify(:event, &text(&1, "#{inspect(event)}"))

    scene = push_graph(scene, graph)
    {:noreply, scene}
  end
end
