defmodule PPhoenixLiveviewCourseWeb.PokemonLive.Pokemon do
  @derive Jason.Encoder
  defstruct name: "", type: nil, image_url: "", id: nil
end

defmodule PPhoenixLiveviewCourseWeb.PokemonLive do
  use PPhoenixLiveviewCourseWeb, :live_view
  alias PPhoenixLiveviewCourseWeb.PokemonLive.Pokemon
  alias PPhoenixLiveviewCourseWeb.PokemonLive.PokemonComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> init_pokemons()}
  end

  @impl true
  def handle_event("choose_pokemon", %{"id" => pokemon_id}, socket) do
    p1_pokemon =
      Enum.find(socket.assigns.pokemons, &(&1.id == String.to_integer(pokemon_id)))

    p2_pokemon = random_pokemon(socket)

    result = battle(p1_pokemon, p2_pokemon)

    payload =
      case battle(p1_pokemon, p2_pokemon) do
        :draw ->
          %{status: :draw, winner: nil, loser: nil}

        {:p1, :p2} ->
          %{
            status: :p1,
            winner: %{player: :p1, pokemon: p1_pokemon},
            loser: %{player: :p2, pokemon: p2_pokemon}
          }

        {:p2, :p1} ->
          %{
            status: :p2,
            winner: %{player: :p2, pokemon: p2_pokemon},
            loser: %{player: :p1, pokemon: p1_pokemon}
          }
      end

    {:noreply,
     socket
     |> assign(p1_pokemon: p1_pokemon, p2_pokemon: p2_pokemon, result: result)
     |> push_event("battle:start", payload)}
  end

  #  PRIVATES
  defp init_pokemons(socket) do
    charmander = %Pokemon{
      id: 1,
      name: "Charmander",
      type: :fire,
      image_url: ~p"/images/charmander.png"
    }

    squirtle = %Pokemon{
      id: 2,
      name: "Squirtle",
      type: :water,
      image_url: ~p"/images/squirtle.png"
    }

    bulbasaur = %Pokemon{
      id: 3,
      name: "Bulbasaur",
      type: :grass,
      image_url: ~p"/images/bulbasaur.png"
    }

    available_pokemons = [charmander, squirtle, bulbasaur]
    socket |> assign(pokemons: available_pokemons, p1_pokemon: nil, p2_pokemon: nil, winner: nil)
  end

  defp random_pokemon(socket) do
    Enum.random(socket.assigns.pokemons)
  end

  defp battle(p1_pokemon, p2_pokemon) do
    cond do
      p1_pokemon.type == :fire && p2_pokemon.type == :grass -> {:p1, :p2}
      p1_pokemon.type == :water && p2_pokemon.type == :fire -> {:p1, :p2}
      p1_pokemon.type == :grass && p2_pokemon.type == :water -> {:p1, :p2}
      p1_pokemon.type == p2_pokemon.type -> :draw
      true -> {:p2, :p1}
    end
  end
end
