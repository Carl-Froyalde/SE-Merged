extends Node

var lvl_select = load("res://Assets/music/LevelSelecOST.mp3")
@onready var _music = $Music

func _ready() -> void:
	pass

func play_levelselect():
	$Music.stream =  lvl_select
	$Music.play()

func stop():
	_music.stop()

func _playFX(stream, volume = 0.0):
	var fx_player =  AudioStreamPlayer2D.new()
	fx_player.stream = stream
	fx_player.name = "FX_player"
	fx_player.volume_db = volume
	add_child(fx_player)
	
	await fx_player.finished
	
	fx_player.queue_free()

func _play(path, volume = 0.0):
	$Music.stream = load(path)
	$Music.volume_db = volume
	$Music.play()
