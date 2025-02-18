defmodule CookbookWeb.GestureLive.SwiftUI do
  use CookbookNative, [:render_component, format: :swiftui]

  def render(assigns) do
    ~LVN"""
    <VStack style="padding()">
      <GroupBox>
        <Text template="label">Drag</Text>
        <Rectangle
          style={[
            "fill(.red)",
            "frame(width: 100, height: 100)",
            "offset(x: gesture_state(:drag, .translation.width), y: gesture_state(:drag, .translation.height))",
            "animation(.bouncy, value: gesture_state(:drag, .translation.width))",
            "animation(.bouncy, value: gesture_state(:drag, .translation.height))",
            "gesture(DragGesture().updating(:drag))",
            "frame(maxHeight: .infinity)"
          ]}
        />
      </GroupBox>

      <GroupBox>
        <Text template="label">Magnify</Text>
        <Rectangle
          style={[
            "fill(.green)",
            "frame(width: 100, height: 100)",
            "scaleEffect(gesture_state(:magnify, .magnification, defaultValue: 1), anchor: UnitPoint(x: gesture_state(:magnify, .startAnchor.x, defaultValue: 0.5), y: gesture_state(:magnify, .startAnchor.y, defaultValue: 0.5)))",
            "animation(.bouncy, value: gesture_state(:magnify, .magnification))",
            "simultaneousGesture(MagnifyGesture().updating(:magnify))",
            "frame(maxHeight: .infinity)"
          ]}
        />
      </GroupBox>

      <GroupBox>
        <Text template="label">Rotate</Text>
        <Rectangle
          style={[
            "fill(.blue)",
            "frame(width: 100, height: 100)",
            "rotationEffect(.degrees(gesture_state(:rotate, .rotation.degrees, defaultValue: 0)), anchor: UnitPoint(x: gesture_state(:magnify, .startAnchor.x, defaultValue: 0.5), y: gesture_state(:magnify, .startAnchor.y, defaultValue: 0.5)))",
            "animation(.bouncy, value: gesture_state(:rotate, .rotation.radians))",
            "simultaneousGesture(RotateGesture().updating(:rotate))",
            "frame(maxHeight: .infinity)"
          ]}
        />
      </GroupBox>
    </VStack>
    """
  end
end
