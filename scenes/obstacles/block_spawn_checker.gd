class_name BlockSpawnChecker
extends Area2D

# Make sure to only look for collisions with Block group

var block: Block

var spawn_location: Vector2

var time_in_tree: float = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_in_tree += delta
	if time_in_tree < 0.1:
		return
	if time_in_tree > 10:
		print(self, " can't find a spawn for ", block)
	if not block: return
	if not spawn_location: return
	
	if has_overlapping_bodies() or has_overlapping_areas():
		for body in get_overlapping_bodies():
			if body.is_in_group("Block"):
				position.y -= 64
				time_in_tree = 0
				return
		for area in get_overlapping_areas():
			if area.is_in_group("Block"):
				position.y -= 64
				time_in_tree = 0
				return
	
	
	
	block.position = position
	add_sibling(block)
	queue_free()
	


func set_block(_block: Block, _spawn_location: Vector2) -> void:
	block = _block
	spawn_location = _spawn_location
