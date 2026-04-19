extends Node

@onready var player: Node2D = $Player
@onready var turret_spawner: Node = $TurretsSpawner

func _ready() -> void:
	randomize()
	player.set_projectile_container(self)
	turret_spawner.spawn_turrets(player)
