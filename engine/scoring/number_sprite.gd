class_name NumberSprite
extends Sprite2D

#enum NumberSprites {ZERO, ONE, TWO, THREE, FOUR, PLUS, FIVE, SIX, SEVEN, EIGHT, NINE, MULTIPLY}
var NumberSpriteFrames: Dictionary =  {
	"0": 0,
	"1": 1,
	"2": 2,
	"3": 3,
	"4": 4,
	"+": 5,
	"5": 6,
	"6": 7,
	"7": 8,
	"8": 9,
	"9": 10,
	"x": 11}

var tween: Tween

#func _ready() -> void:
#	GameEvents.score_changed.connect(on_score_changed)


func set_number_sprite_frame(number: String) -> void:
	frame = NumberSpriteFrames[number]
	tween = create_tween()
	tween.tween_property(self, "modulate", Color(modulate, 1.0), 0.02)
	tween.tween_property(self, "modulate", Color(modulate, 0.5), 0.04)


#func on_score_changed(score: int, delta: int) -> void:
#	tween = create_tween()
#	tween.tween_property(self, "modulate", Color(modulate, 1.0), 0.02)
#	tween.tween_property(self, "modulate", Color(modulate, 0.5), 0.04)
