class_name PlayerUnit extends Unit

@onready var selection_visual: Sprite2D = get_node(^"SelectionVisual")

func toggle_selection_visual(toggle: bool) -> void:
	selection_visual.set_visible(toggle)
