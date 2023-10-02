extends Node2D

@onready var player: Player = $"../Player"
@export var score_display_scene: PackedScene


var i := 0


func _ready() -> void:
	GameEvents.score_changed.connect(on_score_changed)


func on_score_changed(score: int, delta: int) -> void:
	var score_display = score_display_scene.instantiate() as ScoreDisplay
	score_display.position = player.position# + Vector2.DOWN * 8
	get_parent().add_child(score_display)
	score_display.set_score("+" + str(delta))
	
	var scale_tweener := create_tween()
	scale_tweener.tween_property(score_display, "scale", Vector2(0,0), 0.5)
	
	var position_tweener := create_tween()
	position_tweener.tween_property(score_display, "position", score_display.position + Vector2.DOWN * 124, 1)
	position_tweener.tween_callback(score_display.queue_free)
