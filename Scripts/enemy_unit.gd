class_name EnemyUnit extends Unit

@export var detect_range: float = 100.0

func _process(delta: float) -> void:
	if not target:
		for p: PlayerUnit in game_manager.players:
			if not p:
				continue
			
			var distance: float = get_global_position().distance_to(p.get_global_position())
			if distance <= detect_range:
				set_target(p)
	
	super._process(delta)
