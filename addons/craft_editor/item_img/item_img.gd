@tool
class_name ItemIMG
extends PanelContainer

@onready var texture_rect: TextureRect = $TextureRect

signal left_clicked(item_img: ItemIMG)
signal right_clicked(item_img: ItemIMG)

var show_preview: bool = true

var item: Item:
	set(value):
		item = value
		if is_node_ready():
			if item:
				texture_rect.texture = item.texture
			else:
				texture_rect.texture = null

func _ready() -> void:
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	if item:
		texture_rect.texture = item.texture


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			left_clicked.emit(self)
		elif event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			right_clicked.emit(self)
