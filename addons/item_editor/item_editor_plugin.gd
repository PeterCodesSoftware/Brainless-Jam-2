@tool
extends EditorPlugin

const scene: PackedScene = preload("uid://dwkaxh1e106lw")
var scene_instance: Control

func _enter_tree() -> void:
	scene_instance = scene.instantiate()
	EditorInterface.get_editor_main_screen().add_child(scene_instance)
	_make_visible(false)

func _exit_tree() -> void:
	if scene_instance:
		scene_instance.queue_free()

func _make_visible(visible):
	if scene_instance:
		scene_instance.visible = visible

func _has_main_screen() -> bool:
	return true

func _get_plugin_name():
	return "Item Editor Plugin"

func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Node", "EditorIcons")
