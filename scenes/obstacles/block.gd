extends AnimatableBody2D

@export var fall_speed: float = 1.0


func _physics_process(delta: float) -> void:
	move_and_collide(Vector2(0,fall_speed))
