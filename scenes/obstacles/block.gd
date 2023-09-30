class_name Block
extends RigidBody2D

@export var fall_speed: float = 0.5
@export var block_unit_width: int


func _ready() -> void:
	linear_velocity = Vector2(0, fall_speed)

