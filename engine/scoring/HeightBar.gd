extends Node2D

@onready var main: Main = $"../.."
@onready var player: Player = $"../../Player"
@onready var progress_sprite: Sprite2D = $ProgressSprite



func _process(delta: float) -> void:
	progress_sprite.offset.y = clampf(lerpf(0.0, -61.0, main.height_scored_percent), -61.0, 0.0)
