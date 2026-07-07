extends Control


@onready var sfx_slider: HSlider = %SFXSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var fps_slider: HSlider = %FPSSlider
@onready var fps_label: Label = %FPSLabel

func _ready() -> void:
	sfx_slider.value = Global.options.sfx_volume
	music_slider.value = Global.options.music_volume
	fps_slider.value = Global.options.fps
	fps_label.text = "FPS: " + str(Global.options.fps)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/main/main.tscn")

func _on_fps_slider_value_changed(value: float) -> void:
	Audio.click_2_player.play()
	fps_label.text = "FPS: " + str(roundi(value))

func _on_fps_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed:
		return
	
	var value: int = roundi(fps_slider.value)
	Global.options.fps = value
	Engine.max_fps = value
	Engine.physics_ticks_per_second = value

func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed:
		return
	
	Global.options.sfx_volume = sfx_slider.value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), sfx_slider.value)

func _on_music_slider_drag_ended(value_changed: bool) -> void:
	if not value_changed:
		return
	
	Global.options.music_volume = music_slider.value
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), music_slider.value)

func _on_tree_exiting() -> void:
	ResourceSaver.save(Global.options, Global.OPTIONS_PATH)
