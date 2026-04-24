extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.set_projectile_container(self)
	$Torret.set_values($Player, self)
	$Torret2.set_values($Player, self)
	$Torret3.set_values($Player, self)
