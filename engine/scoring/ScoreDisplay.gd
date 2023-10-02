class_name ScoreDisplay
extends Node2D

@export var number_sprites: Array[NumberSprite]


func set_white() -> void:
	for sprite in number_sprites:
		create_tween().tween_property(sprite, "modulate", Color.WHITE, 1.0)


# What if score is lower than before? Need to delete sprites
func set_score(score: String) -> void:
	var i: int = 0
	for c in score:
		if number_sprites.size() < i + 1:
			number_sprites.append(instance_new_number_sprite())
		
		number_sprites[i].set_number_sprite_frame(c)
		i += 1


func instance_new_number_sprite() -> NumberSprite:
	var previous_number_sprite: NumberSprite = number_sprites[number_sprites.size() - 1]
	var new_number_sprite: NumberSprite = previous_number_sprite.duplicate()
#	for number_sprite in number_sprites:
#		number_sprite.position.y -= 16
	new_number_sprite.position.x += 16
	add_child(new_number_sprite)
	return new_number_sprite
