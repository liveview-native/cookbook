defmodule CookbookWeb.CookbookLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view

  @featured_recipes ["search", "card-row", "sectioned-grid", "gesture"]

  def mount(_params, _session, socket) do
    all_recipes = recipes(nil)
    categorized_recipes = Enum.group_by(all_recipes, &(&1.metadata.category))
    categories = categorized_recipes
      |> Map.keys()
      |> Enum.sort()

    {:ok, socket
      |> assign(:recipes, all_recipes)
      |> assign(:selected_category, nil)
      |> assign(:categories, categories)
      |> assign(:featured_recipes, Enum.filter(all_recipes, &(Enum.member?(@featured_recipes, Path.basename(&1.path)))))
    }
  end

  def render(assigns) do
    ~H""
  end

  def handle_event("clear-filter", _params, socket) do
    handle_event("filter", %{ "category" => nil }, socket)
  end
  def handle_event("filter", %{ "category" => category }, socket) do
    {:noreply, socket
      |> assign(:selected_category, category)
      |> assign(:recipes, recipes(category))}
  end

  def recipes(nil) do
    Phoenix.Router.routes(CookbookWeb.Router)
      |> Enum.filter(&(String.starts_with?(&1.path, "/recipes/")))
  end
  def recipes(category) do
    Phoenix.Router.routes(CookbookWeb.Router)
      |> Enum.filter(&(String.starts_with?(&1.path, "/recipes/") and &1.metadata.category == category))
  end
end
