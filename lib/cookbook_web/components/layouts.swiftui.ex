defmodule CookbookWeb.Layouts.SwiftUI do
  use CookbookNative, [:layout, format: :swiftui]

  embed_templates "layouts_swiftui/*"
end
