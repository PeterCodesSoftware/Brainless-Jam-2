extends Control

@onready var available_goslings_label: Label = %AvailableGoslingsLabel

func _ready() -> void:
	GM.goslings_available_changed.connect(update_gosling_label)

func update_gosling_label() -> void:
	available_goslings_label.text = str(GM.goslings_available) + " gosling" + ("s" if GM.goslings_available != 1 else "") + " ready to work"
