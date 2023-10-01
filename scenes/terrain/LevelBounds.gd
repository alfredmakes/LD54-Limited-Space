extends Node2D

@onready var player: CharacterBody2D = $"../Player"


func _physics_process(delta: float) -> void:
	position.y = player.position.y - 112
