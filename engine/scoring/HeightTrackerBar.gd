extends Node2D

var tween: Tween

@onready var original_modulate: Color = $Sprite2D.modulate


func _process(delta: float) -> void:
	tween = create_tween()
	tween.tween_property(self, "position",
		$"../GamePosition".position + Vector2.DOWN * 128, 1.0)
	
	if $"../Player".position.y < position.y + 16:
		$Sprite2D.modulate = Color(original_modulate, 1.0)
	else:
		$Sprite2D.modulate = Color(original_modulate, 0.5)
