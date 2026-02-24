defmodule PPhoenixLiveviewCourseWeb.BlackjackLiveTest do
  use PPhoenixLiveviewCourseWeb.ConnCase
  alias PPhoenixLiveviewCourseWeb.GameLive.Tomatometer

  describe "Tomatometer" do
    # static test
    test "renders tomatometer" do
      tomatometer_html = render_component(Tomatometer, game: %{id: 1}, id: "tomatometer-1")

      assert tomatometer_html =~ "🍎"
      assert tomatometer_html =~ "🍏"
    end
  end
end
