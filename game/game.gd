extends Node

@onready var popup_layer: CanvasLayer = $PopupLayer

func _ready() -> void:
	GM.display_popup.connect(display_popup)

func display_popup(node: Node) -> void:
	popup_layer.add_child(node)
