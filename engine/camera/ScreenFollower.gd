extends Node2D

@onready var camera: Camera2D = $"../Camera2D"



func _process(delta: float) -> void:
	position = camera.get_screen_center_position()
	
