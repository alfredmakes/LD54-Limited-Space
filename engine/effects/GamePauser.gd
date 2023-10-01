extends Node



func _ready() -> void:
	GameEvents.player_died.connect(freeze)


func freeze() -> void:
	Engine.time_scale = 0.01
	var tween := create_tween().tween_method(set_engine_time_scale, 0.01, 1, 0.5)#.set_delay(0.01)


func set_engine_time_scale(time_scale: float) -> void:
	Engine.time_scale = time_scale
