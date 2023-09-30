extends Node2D
# Spawns blocks and enemies etc

@export var block_scene: PackedScene

@export var spawn_locations: Array[Vector2]

@onready var block_spawn_timer: Timer = $BlockSpawnTimer



func _process(delta: float) -> void:
	pass


func spawn_block(spawn_point: Vector2) -> void:
	var block_instance = block_scene.instantiate() as AnimatableBody2D
	
	add_child(block_instance)
	block_instance.position = spawn_point


func _on_block_spawn_timer_timeout() -> void:
	spawn_block(spawn_locations.pick_random())
