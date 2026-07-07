class_name State
extends Node

@warning_ignore("unused_signal")
signal switch_state(next_state_path: String)


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter(_previous_state_path: String) -> void:
	pass


func exit(_next_state_path: String) -> void:
	pass
