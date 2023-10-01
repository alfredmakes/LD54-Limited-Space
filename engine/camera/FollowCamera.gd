extends Camera2D

@onready var player: CharacterBody2D = $"../Player"

func _physics_process(delta: float) -> void:
	
	var target_position = player.position.y - 40
	
#	target_position += player.velocity.y / 1.5
	
	position.y = target_position
	
	
