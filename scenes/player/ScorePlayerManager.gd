extends Node2D

@onready var template_score_player: AudioStreamPlayer2D = $ScorePlayer

var score_players: Array[AudioStreamPlayer2D]

var score_player_index = 0




func _ready() -> void:
	score_players.append(template_score_player)
	GameEvents.score_changed.connect(play_score_sfx)


func play_score_sfx(score: int, delta: int) -> void:
	var bus_pitch_shift = AudioServer.get_bus_effect(1, 1) as AudioEffectPitchShift
	var bus_low_pass_filter = AudioServer.get_bus_effect(1, 2) as AudioEffectLowPassFilter
#	bus_pitch_shift.pitch_scale = lerpf(0.9, 1.1, score / 50.0)
	bus_low_pass_filter.cutoff_hz = clampf(lerpf(600, 1000, score / 50.0), 600, 1000)
	
	
	if score_players[score_player_index].is_playing():
		var new_score_player = template_score_player.duplicate()
		add_child(new_score_player)
#		new_score_player.stop()
#		new_score_player.pitch_scale = randf_range(0.9, 1.1)
		score_players.append(new_score_player)
		new_score_player.play()
	else:
		score_players[score_player_index].play()
		score_player_index = (score_player_index + 1) % score_players.size()
