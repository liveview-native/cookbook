defmodule CookbookWeb.ChartsLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <VStack
      style={[
        ~s[animation(.default, value: attr("length"))],
        "padding()",
        ~s[navigationTitle("Charts")]
      ]}
      length={length(@data)}
    >
      <Chart>
        <BarMark
          :for={{point, index} <- Enum.with_index(@data)}

          x:label="X"
          x:value={index}

          y:label="Y"
          y:value={point}

          style='foregroundStyle(by: .value("X", attr("x:value")));'
        />
      </Chart>
      <Chart>
        <PointMark
          :for={{point, index} <- Enum.with_index(@data)}

          x:label="X"
          x:value={index}

          y:label="Y"
          y:value={point}
        />
        <LineMark
          :for={{point, index} <- Enum.with_index(@data)}

          x:label="X"
          x:value={index}

          y:label="Y"
          y:value={point}

          style="foregroundStyle(.tertiary);"
        />
        <AreaMark
          :for={{point, index} <- Enum.with_index(@data)}

          x:label="X"
          x:value={index}

          y:label="Y"
          y:value={point}

          style="foregroundStyle(.quinary);"
        />
      </Chart>
      <.button phx-click="add-item" style="buttonStyle(.borderedProminent);">
        Add Item
      </.button>
    </VStack>
    """
  end
end
