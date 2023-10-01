extends CharacterBody2D


const MAX_SPEED := 200.0
const ACCELERATION := 700.0
const DECELERATION := 200.0
const DRAG_STRENGTH := 1.0

const AIR_CONTROL := 0.5
const JUMP_VELOCITY := -400.0
const WALL_JUMP_VELOCITY := 800.0
const COYOTE_TIME := 0.1

var _drag_factor := 0.0

var _air_control_factor := 1.0
var time_in_air := 0.0

var wall_slide_direction := 0.0

@onready var sprite: Sprite2D = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var movement_direction: float = 0.0


func _ready() -> void:
	_drag_factor = DRAG_STRENGTH * (ACCELERATION / (MAX_SPEED * MAX_SPEED))


func _process(delta: float) -> void:
	process_sprite_fx()


func _physics_process(delta: float) -> void:
	if is_on_floor():
		_air_control_factor = 1
	else:
		_air_control_factor = AIR_CONTROL
		
	# Add the gravity.
	if not is_on_floor():
		if abs(wall_slide_direction) > 0.5:
			var wall_slide_gravity_amount = clamp(remap(velocity.y,
				0.0, JUMP_VELOCITY, 0.5, 1.0), 0.5, 1.0)
			print(floor(velocity.y), " gravity: ", wall_slide_gravity_amount)
			velocity.y += gravity * delta * wall_slide_gravity_amount
		else:
			velocity.y += gravity * delta
		time_in_air += delta
	else:
		time_in_air = 0
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if time_in_air < COYOTE_TIME:
			velocity.y = JUMP_VELOCITY
			time_in_air = COYOTE_TIME
		elif abs(wall_slide_direction) > 0.5:
			velocity.y = JUMP_VELOCITY
			velocity.x = wall_slide_direction * WALL_JUMP_VELOCITY / 2
			time_in_air = COYOTE_TIME
		
	
	# Get the input movement_direction and handle the movement/deceleration.
	movement_direction = Input.get_axis("ui_left", "ui_right")
	var change_direction_boost := 1.0
	if (movement_direction < 0 and velocity.x > 0) or (
		movement_direction > 0 and velocity.x < 0):
		change_direction_boost = 2
	
	var horizontal_velocity = move_toward(velocity.x, 0,
		_drag_factor * (velocity.x * velocity.x) * _air_control_factor * delta)
	
	if movement_direction != 0.0:
		horizontal_velocity = move_toward(velocity.x, 0,
			_drag_factor * (velocity.x * velocity.x) * _air_control_factor * delta)
		horizontal_velocity = move_toward(horizontal_velocity, movement_direction * MAX_SPEED,
			ACCELERATION * _air_control_factor * change_direction_boost * delta)
	else:
#		horizontal_velocity = move_toward(horizontal_velocity, 0, ACCELERATION * _air_control_factor * delta)
		horizontal_velocity = move_toward(horizontal_velocity, 0, DECELERATION * _air_control_factor * delta)
	
	velocity.x = horizontal_velocity
	move_and_slide()
	
	if get_slide_collision_count() == 0:
		wall_slide_direction = 0.0
		return
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
#		print("Collided with: ", collision.get_collider().name)
		if abs(collision.get_normal().x) > 0.5:
			wall_slide_direction = ceil(collision.get_normal().x)
		else:
			wall_slide_direction = 0.0
		


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func process_sprite_fx() -> void:
	if abs(wall_slide_direction) < 0.5:
		
		if velocity.x < 0:
			sprite.frame = 1
			sprite.flip_h = true
		elif velocity.x > 0:
			sprite.frame = 1
			sprite.flip_h = false
		elif abs(velocity.y) > 0:
			sprite.frame = 1
		else:
			sprite.frame = 0
	else:
		sprite.frame = 2
		sprite.flip_h = wall_slide_direction > 0
