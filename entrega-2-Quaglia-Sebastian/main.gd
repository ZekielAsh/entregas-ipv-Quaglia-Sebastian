extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.set_projectile_container(self)
	$Torret.set_values($Player, self)
