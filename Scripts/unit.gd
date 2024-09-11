class_name Unit extends CharacterBody2D

@export var health: int = 100
@export var damage: int = 20

@export var move_speed: float = 50.0
@export var attack_range: float = 20.0
@export var attack_rate: float = 0.5

@export var is_player: bool = false

var last_attack_time: float = 0.0

var target: Unit = null

@onready var agent: NavigationAgent2D = %NavigationAgent2D
@onready var sprite: Sprite2D = %Sprite2D

func _process(_delta: float) -> void:
	_target_check()

func _physics_process(_delta: float) -> void:
	if agent.is_navigation_finished():
		return
	
	var direction: Vector2 = get_global_position().direction_to(agent.get_next_path_position())
	set_velocity(direction * move_speed)
	
	move_and_slide()

func set_target(new_target: Unit) -> void:
	target = new_target

func move_to_location(location: Vector2) -> void:
	target = null
	agent.set_target_position(location)

func take_damage(damage_to_take: int) -> void:
	health -= damage_to_take
	if health <= 0:
		queue_free()

func _target_check() -> void:
	if target:
		var distance: float = get_global_position().distance_to(target.get_global_position())
		if distance <= attack_range:
			agent.set_target_position(get_global_position())
			_try_attack_target()
		else:
			agent.set_target_position(target.get_global_position())

func _try_attack_target() -> void:
	var current_time: float = Time.get_unix_time_from_system()
	if current_time - last_attack_time > attack_rate:
		target.take_damage(damage)
		last_attack_time = current_time
