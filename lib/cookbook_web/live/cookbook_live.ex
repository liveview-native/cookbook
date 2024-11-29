defmodule CookbookWeb.CookbookLive do
  use CookbookWeb, :live_view
  use CookbookNative, :live_view
  alias QRCode.Render.SvgSettings

  @featured_recipes ["search", "card-row", "sectioned-grid", "gesture"]

  def handle_params(_params, uri, socket) do
    uri = URI.parse(uri) |> Map.put(:query, nil) |> URI.to_string()

    {:ok, qr} =
      uri
      |> QRCode.create(:high)
      |> QRCode.render(:svg, %SvgSettings{flatten: true})
      |> QRCode.to_base64()

    {:noreply,
     socket
     |> assign(:qr, qr)
     |> assign(:uri, uri)}
  end

  def mount(_params, _session, socket) do
    all_recipes = recipes("All", "")
    categorized_recipes = Enum.group_by(all_recipes, & &1.metadata.category)

    categories = categorized_recipes
      |> Map.keys()
      |> Enum.sort()
    categories = ["All" | categories]

    {:ok,
     socket
     |> assign(:recipes, all_recipes)
     |> assign(:selected_category, "All")
     |> assign(:query, "")
     |> assign(:scope, "")
     |> assign(:categories, categories)
     |> assign(
       :featured_recipes,
       Enum.filter(all_recipes, &Enum.member?(@featured_recipes, Path.basename(&1.path)))
     )}
  end

  # def handle_event("clear-filter", _params, socket) do
  #   handle_event("filter", %{"category" => nil}, socket)
  # end

  def handle_event("filter", %{"category" => category}, socket) do
    {:noreply,
     socket
     |> assign(:selected_category, category)
     |> assign(:recipes, recipes(category, socket.assigns.query))}
  end

  def handle_event("query-changed", %{ "query" => query }, socket) do
    {:noreply,
     socket
     |> assign(:query, query)
     |> assign(:recipes, recipes(socket.assigns.selected_category, query))}
  end

  def recipes(category, query) do
    query = String.downcase(query)
    Phoenix.Router.routes(CookbookWeb.Router)
    |> Enum.filter(
      &(String.starts_with?(&1.path, "/recipes/") and (&1.metadata.category == category or category == "All"))
    )
    |> Enum.filter(&(String.contains?(String.downcase(&1.metadata.title), query) or String.contains?(String.downcase(&1.metadata.description), query)))
  end

  def render(assigns) do
    ~H"""
    <div class="h-full flex flex-col gap-4 items-center">
      <div class="flex-grow flex flex-col gap-4 items-center justify-center">
        <p class="text-xl">See all <%= length(@recipes) %> recipes on your iPhone</p>
        <.link
          href={"https://appclip.apple.com/id?p=com.dockyard.LiveViewNativeGo.Clip&liveview=#{@uri}"}
          class="rounded-lg bg-zinc-900 px-3 py-2 hover:bg-zinc-800/80 text-white"
        >
          <.icon name="hero-rocket-launch-mini" /> Open in <span class="font-semibold">LVN Go</span>
        </.link>
      </div>
      <div class="w-full flex flex-grow flex-col gap-8 items-center justify-center border-zinc-200 border-t">
        <p class="text-xl">Already have <span class="font-semibold">LVN Go</span>?</p>
        <img src={"data:image/svg+xml; base64, #{@qr}"} class="max-w-32 md:max-w-56" />
        <p class="text-sm">
          Scan the code with <span class="font-semibold">LVN Go</span> to open the cookbook.
        </p>
      </div>
    </div>
    """
  end
end
