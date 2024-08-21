defmodule CookbookWeb.CookbookLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  @featured_recipes ["search", "card-row", "sectioned-grid", "gesture"]

  def mount(_params, _session, socket) do
    recipes = Phoenix.Router.routes(CookbookWeb.Router)
      |> Enum.filter(&(String.starts_with?(&1.path, "/recipes/")))

    {:ok, socket
      |> assign(:recipes, recipes)
      |> assign(:featured_recipes, Enum.filter(recipes, &(Enum.member?(@featured_recipes, Path.basename(&1.path)))))
    }
  end

  def render(assigns) do
    ~H""
  end
end
