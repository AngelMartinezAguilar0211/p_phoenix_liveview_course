defmodule PPhoenixLiveviewCourseWeb.GameLive.Show do
  use PPhoenixLiveviewCourseWeb, :live_view

  alias PPhoenixLiveviewCourse.Catalog
  alias PPhoenixLiveviewCourse.Rating
  alias PPhoenixLiveviewCourse.Rating.Tomatoes
  alias PPhoenixLiveviewCourseWeb.GameLive.GameComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:game, Catalog.get_game!(id))
     |> assign_tomatoes_rating(id)}
  end

  defp assign_tomatoes_rating(socket, game_id) do
    case Rating.get_tomatoes_by_game(game_id) do
      %Tomatoes{} = tomatoes ->
        socket |> assign(:tomatoes, tomatoes)

      _ ->
        socket |> put_flash(:error, "Cannot get tomatoes info")
    end
  end

  defp page_title(:show), do: "Show Game"
  defp page_title(:edit), do: "Edit Game"
end
