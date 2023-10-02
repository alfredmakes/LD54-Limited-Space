extends Node2D

@onready var score_display: ScoreDisplay = $ScoreDisplay


func _ready() -> void:
	GameEvents.multiplier_changed.connect(on_multiplier_changed)


func on_multiplier_changed(multiplier: int) -> void:
	score_display.set_score("x" + str(multiplier))
