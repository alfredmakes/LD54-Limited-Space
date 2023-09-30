class_name Block
extends AnimatableBody2D

@export var fall_speed: float = 0.5
@export var block_unit_width: int


func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(Vector2(0,fall_speed))
	
	if not collision_info: return
	
	if collision_info.get_remainder().length() < 0.1:
		GameEvents.block_landed.emit()
		set_physics_process(false)


func _on_hitbox_body_entered(body: Node2D) -> void:
	print(body)
