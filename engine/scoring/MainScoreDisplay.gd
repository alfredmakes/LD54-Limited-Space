extends Node2D


@onready var score_display: Node2D = $ScoreDisplay




func _ready() -> void:
	GameEvents.score_changed.connect(on_score_changed)



func on_score_changed(score: int, delta: int) -> void:
	score_display.set_score(str(score))
