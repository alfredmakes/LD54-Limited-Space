extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const COYOTE_TIME = 0.1

var time_in_air = 0.0

var wall_slide_direction = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if abs(wall_slide_direction) > 0.5:
			velocity.y += gravity * delta * 0.4
		else:
			velocity.y += gravity * delta
		time_in_air += delta
	else:
		time_in_air = 0
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and time_in_air < COYOTE_TIME:
		velocity.y = JUMP_VELOCITY
		time_in_air = COYOTE_TIME
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
#
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.get_collider().name)
		if abs(collision.get_normal().x) > 0.5:
			wall_slide_direction = ceil(collision.get_normal().x)
		else:
			wall_slide_direction = 0.0
		
		print(wall_slide_direction)



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
