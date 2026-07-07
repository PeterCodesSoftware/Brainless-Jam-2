extends Node

var click_1_player: AudioStreamPlayer
var click_1: AudioStream = preload("res://common/sounds/click_1.wav")
var click_2_player: AudioStreamPlayer
var click_2: AudioStream = preload("res://common/sounds/click_2.wav")

var music_player: AudioStreamPlayer
var song_1: AudioStream # preload stream here

func _ready() -> void:
	click_1_player = AudioStreamPlayer.new()
	click_1_player.bus = "SFX"
	click_1_player.stream = click_1
	add_child(click_1_player)
	
	click_2_player = AudioStreamPlayer.new()
	click_2_player.bus = "SFX"
	click_2_player.stream = click_2
	add_child(click_2_player)
	
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"
	music_player.stream = song_1
	add_child(music_player)
	music_player.play()
	music_player.finished.connect(music_player.play)
