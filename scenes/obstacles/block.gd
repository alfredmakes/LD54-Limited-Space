class_name Block
extends AnimatableBody2D

@onready var block_check_area: Area2D = $Area2D

@export var starting_fall_speed: float = 50
@export var block_unit_width: int

var fall_speed: float


func _ready() -> void:
	fall_speed = starting_fall_speed + randf_range(-10.0, 10.0)


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = KinematicCollision2D.new()
	if test_move(transform, Vector2(0, fall_speed * delta), collision, 0.001):
#		print(self, " ", position, " collided with ", collision.get_collider(), " ", collision.get_collider().position)
		if collision.get_collider().is_in_group("Player"):
			
			var player = collision.get_collider() as CharacterBody2D
			if player.is_on_floor() and player.position.y > position.y:
				GameEvents.player_died.emit()
		elif collision.get_collider().is_in_group("Block") and not collision.get_collider().fall_speed == 0:
#			print("Collided, old speed ", fall_speed, " new speed ", collision.get_collider().fall_speed)
			fall_speed = collision.get_collider().fall_speed
		else:
			stop()
	
	position += Vector2(0, fall_speed * delta)


func start() -> void:
	fall_speed = starting_fall_speed + randf_range(-10.0, 10.0)
	set_physics_process(true)
	alert_blocks_above()


func stop() -> void:
	position.x = ceil(position.x)
	position.y = ceil(position.y)
	fall_speed = 0.0
	$AudioStreamPlayer2D.play()
	set_physics_process(false)


func alert_blocks_above() -> void:
	if not block_check_area.has_overlapping_bodies(): return
	
	for body in block_check_area.get_overlapping_bodies():
		if body.is_in_group("Block"):
			body.start()
	
	print(block_check_area.get_overlapping_bodies())


func smash() -> void:
	alert_blocks_above()
	$AnimationPlayer.play("block_animation_library/smash")
