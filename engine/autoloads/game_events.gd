extends Node

signal block_landed
signal player_died
signal enemy_squished
signal block_smashed
signal score_changed(score: int, delta: int)
signal multiplier_changed(multiplier: int)



func sleep(sec: float):
	OS.delay_msec(int(sec * 1000))
