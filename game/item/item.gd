class_name Item
extends Resource

const ITEMS_PATH: String = "res://game/item/items/"

static var items_by_name: Dictionary[String, Item] = {}

@export var name: String = ""
@export var texture: Texture2D

static func _static_init() -> void:
	for item_path: String in DirAccess.get_files_at(ITEMS_PATH):
		var item: Item = load(ITEMS_PATH + item_path)
		items_by_name[item.name] = item
