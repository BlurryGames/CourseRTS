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

func _ready() -> void:
	pass

func set_target(new_target: Unit) -> void:
	target = new_target

func move_to_location(location: Vector2) -> void:
	target = null
	agent.set_target_position(location)

func take_damage(damage_to_take: int) -> void:
	health -= damage_to_take
	if health <= 0:
		queue_free()

func _try_attack_target() -> void:
	var current_time: float = Time.get_unix_time_from_system()
	if current_time - last_attack_time > attack_rate:
		target.take_damage(damage)
		last_attack_time = current_time
