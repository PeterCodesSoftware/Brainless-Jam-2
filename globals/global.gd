extends Node

const OPTIONS_PATH: String = "user://options_res.tres"
var options: OptionsRes

func _ready() -> void:
	
	if FileAccess.file_exists(OPTIONS_PATH):
		options = ResourceLoader.load(OPTIONS_PATH, "OptionsRes")
	else:
		options = OptionsRes.new()
	
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), options.sfx_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), options.music_volume)
	Engine.max_fps = options.fps
	Engine.physics_ticks_per_second = options.fps
