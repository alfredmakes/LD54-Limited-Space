extends Node2D
# Spawns blocks and enemies etc

@export var terrain_scene: PackedScene

@export var block_scenes: Array[PackedScene]

@export var spawn_locations: Array[Vector2]
var vertical_spawn_offset: float = 0.0

@export var block_spawn_checker: PackedScene

@onready var block_spawn_timer: Timer = $BlockSpawnTimer

@export var camera_move_time: float = 1.0

@export var time_since_camera_move: float = 0.0

@onready var game_position: Node2D = $GamePosition

@onready var player: CharacterBody2D = $Player

var score: float = 3.0

var last_terrain_height: float = 0.0

# Should probably pick location and block independently,
# then rotate block if it would otherwise go off end of screen

# Ahh we need the camera to follow player vertically, rather than scroll

func _ready() -> void:
#	GameEvents.block_landed.connect(spawn_block)
	pass


func _process(delta: float) -> void:
	time_since_camera_move += delta
	if time_since_camera_move > camera_move_time:
		time_since_camera_move -= camera_move_time
#		game_position.position.y -= 1
	
	if last_terrain_height > game_position.position.y:
		spawn_terrain()
	
	if game_position.position.y > player.position.y - 150:
		game_position.position.y = player.position.y - 150
		if not player.dead and score != floor(abs(game_position.position.y)):
			score = floor(abs(game_position.position.y))
			print("Score: ", score)


func spawn_block_spawner() -> void:
	
	var block_spawn_checker_instance = block_spawn_checker.instantiate() as BlockSpawnChecker
	
	var block := get_block()
	
	block_spawn_checker_instance.position = block.position
	block_spawn_checker_instance.set_block(block, block.position)
	
	add_child(block_spawn_checker_instance)


func get_block() -> Block:
	var block_scene = block_scenes.pick_random()
	
	var block_instance = block_scene.instantiate() as Block
	
	var spawn_location = spawn_locations.slice(
		0, spawn_locations.size() + 1 - block_instance.block_unit_width).pick_random()
	
	block_instance.position = spawn_location + game_position.position
	
	return block_instance

func spawn_terrain() -> void:
	last_terrain_height -= 32
	var terrain = terrain_scene.instantiate()
	terrain.position.y = last_terrain_height
	$Terrains.add_child(terrain)


func _on_block_spawn_timer_timeout() -> void:
	spawn_block_spawner()
	block_spawn_timer.wait_time = lerpf(3.0, 0.2, score / 5000)
	print("Block every ", block_spawn_timer.wait_time, "s")


