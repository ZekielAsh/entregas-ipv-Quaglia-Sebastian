extends Node2D

@export var turret_scene: PackedScene
@export var spawn_radius: float = 300.0
@export var turret_count: int = 3

func _ready():
	randomize()
	call_deferred("spawn_turrets")

func spawn_turrets():
	for i in turret_count:
		var turret_instance: Node2D = turret_scene.instantiate()
		
		var offset = Vector2(
			randf_range(-spawn_radius, spawn_radius),
			randf_range(-spawn_radius, spawn_radius)
		)
		
		var spawn_position = global_position + offset
		
		get_parent().add_child(turret_instance)
		turret_instance.call_deferred("initialize", spawn_position, get_parent())
		
