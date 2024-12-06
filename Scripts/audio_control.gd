extends Node

var lvl_select = load("res://Assets/music/LevelSelecOST.mp3")
@onready var _music = $Music

func _ready() -> void:
	$Music.autoplay = true

func play_levelselect():
	$Music.stream =  lvl_select
	$Music.play()

func stop():
	_music.stop()

func _playFX(stream, volume):
	# Check if the file exists
	if not ResourceLoader.exists(stream):
		print("Error: Sound file not found:", stream)
		return
	
	var fx_player = AudioStreamPlayer2D.new()
	fx_player.stream = load(stream)
	fx_player.name = "FX_player"
	fx_player.volume_db = volume
	fx_player.max_distance = 10000
	add_child(fx_player)

	# Play the sound
	fx_player.play()

	# Wait for the duration of the audio
	var duration = fx_player.stream.get_length()
	await get_tree().create_timer(duration).timeout
	
	# Free the node
	fx_player.queue_free()

func _play(path, volume = 0.0):
	$Music.stream = load(path)
	$Music.volume_db = volume
	$Music.play()
