class_name ItemSlot
extends PanelContainer

@onready var label: Label = $MarginContainer/Label

var item: Item
var amount: int

func _ready() -> void:
	if not item:
		push_error("item not given to slot")
		return
	
	$TextureRect.texture = item.texture
	label.text = str(amount)
