class_name ItemSlot
extends PanelContainer

@onready var label: Label = $MarginContainer/Label

var item: Item
var amount: int:
	set(value):
		amount = value
		if is_node_ready():
			label.text = str(amount)

func _ready() -> void:
	if not item:
		push_error("item not given to slot")
		return
	
	$TextureRect.texture = item.texture
	label.text = str(amount)
