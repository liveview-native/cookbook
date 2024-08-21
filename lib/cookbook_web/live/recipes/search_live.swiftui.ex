defmodule CookbookWeb.SearchLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <List
      style={[
        ~s[navigationTitle("Search")],
        ~s[searchable(text: attr("searchText"), prompt: "Search for something...")],
        ~s[onSubmit(of: .search, action: event("search"))]
      ]}
      searchText={@search_text}
      phx-change="search-changed"
      phx-debounce={250}
    >
      <Text><%= @entered_search %></Text>
    </List>
    """
  end
end
