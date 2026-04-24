extends StaticBody2D

@onready var fire_position: Node2D = $FirePosition
@onready var fire_timer: Timer = $FireTimer
@export var projectile_scene: PackedScene
@onready var ray: RayCast2D = $LineOfSight

var target: Node2D
var projectile_container: Node

func _ready():
	fire_timer.timeout.connect(fire_at_player)
	add_to_group("turret")

func initialize(turret_pos: Vector2, container: Node):
	global_position = turret_pos
	self.projectile_container = container

func fire_at_player():
	if target == null: return
	
	ray.target_position = to_local(target.global_position)
	ray.force_raycast_update()
	
	if ray.is_colliding():
		var collider = ray.get_collider()
		if !collider.is_in_group("player"): return
	
	var proj_instance = projectile_scene.instantiate()
	proj_instance.initialize(
		projectile_container,
		fire_position.global_position,
		fire_position.global_position.direction_to(target.global_position),
		false,
		self
	)

func perish():
	queue_free()


func _on_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		target = body
		fire_timer.start()


func _on_detection_zone_body_exited(body):
	if body == target:
		target = null
		fire_timer.stop()
