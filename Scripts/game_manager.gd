class_name GameManager extends Node2D

var players: Array[PlayerUnit] = []
var enemies: Array[EnemyUnit] = []

var selected_unit: PlayerUnit = null

func _input(event: InputEvent) -> void:
	var mouse_event := event as InputEventMouseButton
	if mouse_event and mouse_event.is_pressed():
		var index: MouseButton = mouse_event.get_button_index()
		if index == MOUSE_BUTTON_LEFT:
			_try_select_unit()
		elif index == MOUSE_BUTTON_RIGHT:
			_try_command_unit()

func _get_selected_unit() -> Unit:
	var unit: Unit = null
	
	var space: PhysicsDirectSpaceState2D = get_world_2d().get_direct_space_state()
	var query := PhysicsPointQueryParameters2D.new()
	query.set_position(get_global_mouse_position())
	
	var intersection: Array[Dictionary] = space.intersect_point(query, 1)
	if not intersection.is_empty():
		unit = intersection[0].collider
	
	return unit

func _select_unit(unit: Unit) -> void:
	_unselect_unit()
	selected_unit = unit
	selected_unit.toggle_selection_visual(true)

func _try_select_unit() -> void:
	var unit: Unit = _get_selected_unit()
	if unit and unit.is_player:
		_select_unit(unit)
	else:
		_unselect_unit()

func _try_command_unit() -> void:
	if not selected_unit:
		return
	
	var target: Unit = _get_selected_unit()
	if target and not target.is_player:
		selected_unit.set_target(target)
	else:
		selected_unit.move_to_location(get_global_mouse_position())

func _unselect_unit() -> void:
	if selected_unit:
		selected_unit.toggle_selection_visual(false)
	
	selected_unit = null
