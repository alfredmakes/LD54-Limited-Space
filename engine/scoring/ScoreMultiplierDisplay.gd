extends Node2D

@onready var score_display: ScoreDisplay = $ScoreDisplay


func _ready() -> void:
	GameEvents.multiplier_changed.connect(on_multiplier_changed)


func on_multiplier_changed(multiplier: int) -> void:
	score_display.set_score("x" + str(multiplier))
	if multiplier >= 5:
		score_display.modulate = Color.RED
	elif multiplier >= 3:
		score_display.modulate = Color.YELLOW
	else:
		score_display.modulate = Color.WHITE
