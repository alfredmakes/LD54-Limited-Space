extends CharacterBody2D

var player: CharacterBody2D

const MAX_SPEED = 65.0
const ACCELERATION = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player") as CharacterBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.position.x <= position.x and scale.x == 1:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _physics_process(delta: float) -> void:
	var direction = position.direction_to(player.position)
	
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("Player"):
			if player.position.y > position.y + 5:
				GameEvents.player_died.emit()
			else:
				player.squished_enemy()
				GameEvents.enemy_squished.emit()
				$AnimationPlayer.play("die")
