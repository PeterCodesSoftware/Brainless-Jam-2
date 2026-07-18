class_name CraftSlot
extends PanelContainer

@onready var texture_rect: TextureRect = $TextureRect

signal left_clicked(craft_slot: CraftSlot)
signal right_clicked(craft_slot: CraftSlot)

var show_preview: bool = true

var item: Item:
	set(value):
		item = value
		if is_node_ready():
			if item:
				texture_rect.texture = item.texture
			else:
				texture_rect.texture = null

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			left_clicked.emit(self)
		elif event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			right_clicked.emit(self)
