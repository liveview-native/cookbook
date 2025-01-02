defmodule CookbookWeb.SearchLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <VStack
      style={[
        ~s[navigationTitle("Search")],
        ~s[searchable(text: attr("searchText"), prompt: "Search for something...")],
        ~s[onSubmit(of: .search, action: event("search"))]
      ]}
      searchText={@search_text}
      phx-change="search-changed"
      phx-debounce={250}
    >
      <LabeledContent :if={@entered_search != ""} style="padding();">
        <Text template="label" style="bold();">Entered Search</Text>
        <%= @entered_search %>
      </LabeledContent>
      <ContentUnavailableView :if={@entered_search == ""}>
        <Label systemImage="magnifyingglass">
          No Results
        </Label>
        <Text template="description">Search in the top bar.</Text>
        <Text :interface-target="macos" template="description">Press enter to perform the search.</Text>
      </ContentUnavailableView>
    </VStack>
    """
  end
end
