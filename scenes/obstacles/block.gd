class_name Block
extends AnimatableBody2D

@export var fall_speed: float = 50
@export var block_unit_width: int



func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = KinematicCollision2D.new()
	if test_move(transform, Vector2(0, fall_speed * delta), collision, 0.001):
#		print(self, " ", position, " collided with ", collision.get_collider(), " ", collision.get_collider().position)
		if collision.get_collider().is_in_group("Player"):
			
			var player = collision.get_collider() as CharacterBody2D
			if player.is_on_floor():
				print("yer dead")
			else:
				position += Vector2(0, fall_speed * delta)
				return
			
		position.x = ceil(position.x)
		position.y = ceil(position.y)
		set_physics_process(false)
		return
	
	position += Vector2(0, fall_speed * delta)
