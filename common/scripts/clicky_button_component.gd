class_name ClickyButtonComponent
extends Node

func _ready() -> void:
	if not get_parent() is Button:
		push_warning("Clicky Button Component attached to non-button")
	
	var parent: BaseButton = get_parent()
	parent.button_down.connect(Audio.click_1_player.play)
	parent.button_up.connect(Audio.click_2_player.play)
