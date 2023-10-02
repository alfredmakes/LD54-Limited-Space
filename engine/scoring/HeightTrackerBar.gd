extends Node2D

var position_tween: Tween

var color_tween: Tween

@onready var original_modulate: Color = $Sprite2D.modulate


func _ready() -> void:
	GameEvents.score_changed.connect(color_pulse)


func _process(delta: float) -> void:
	position_tween = create_tween()
	position_tween.tween_property(self, "position",
		$"../GamePosition".position + Vector2.DOWN * 128, 1.0)
	
#	if $"../Player".position.y < position.y + 16:
#		$Sprite2D.modulate = Color(original_modulate, 1.0)
#	else:
#		$Sprite2D.modulate = Color(original_modulate, 0.5)


func color_pulse(score: int, delta: int) -> void:
	color_tween = create_tween()
	color_tween.tween_property($Sprite2D, "modulate", Color(original_modulate, 1.0), 0.02)
	color_tween.tween_property($Sprite2D, "modulate", Color(original_modulate, 0.5), 0.04)
