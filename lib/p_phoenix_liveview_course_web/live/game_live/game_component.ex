defmodule PPhoenixLiveviewCourseWeb.GameLive.GameComponent do
  use Phoenix.Component

  attr :count, :integer, required: true
  attr :type, :atom, default: :good
  attr :game_id, :integer, required: true

  attr :on_tomatoe, :string, default: "on_tomatoe"

  def tomatoe_button(assigns) do
    ~H"""
    <button
      phx-click={@on_tomatoe}
      phx-value-type={Atom.to_string(@type)}
      phx-value-count={@count}
      class="p-2 border"
    >
      <span>{@count}</span>
      <span>{if @type == :good, do: "🍎", else: "🍏"}</span>
    </button>
    """
  end
end
