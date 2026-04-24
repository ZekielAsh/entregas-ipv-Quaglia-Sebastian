extends Sprite2D

@onready var lifetime_timer = $LifetimeTimer
@onready var hitbox: Area2D = $Hitbox
@onready var ray: RayCast2D = $RayCast2D
@export var VELOCITY: float = 800.0

var direction: Vector2
var from_player: bool

func _ready():
	lifetime_timer.timeout.connect(_on_lifetime_timer_timeout)
	hitbox.body_entered.connect(_on_body_entered)

func initialize(container, spawn_position, dir, from_p, owner):
	container.add_child(self)
	self.direction = dir
	self.from_player = from_p
	self.set_meta("owner", owner)
	global_position = spawn_position
	
	lifetime_timer.start()

func _physics_process(delta):
	var motion = direction.normalized() * VELOCITY * delta
	
	ray.target_position = motion
	ray.force_raycast_update()
	
	if ray.is_colliding():
		var collider = ray.get_collider()
		
		if collider == get_meta("owner"):
			position += motion
			return
		if from_player and collider.is_in_group("turret"):
			collider.perish()
		elif !from_player and collider.is_in_group("player"):
			pass
		if collider.is_in_group("floor") or collider.is_in_group("wall"):
			pass
		_remove()
		
	else:
		position += motion

func _on_body_entered(body):
	if from_player and body.is_in_group("turret"):
		body.perish()
		_remove()
	elif !from_player and body.is_in_group("player"):
		_remove()
	elif body == get_meta("owner"):
		return

func _on_lifetime_timer_timeout():
	_remove()

func _remove():
	queue_free()
