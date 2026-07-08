@tool
extends PanelContainer

const items_path: String = "res://game/item/items/"
const item_texture_paths_path: String = "user://item_texture_paths.txt"

@onready var item_name_line: LineEdit = $HBoxContainer/VBoxContainer/ItemNameLine
@onready var texture_select_button: OptionButton = $HBoxContainer/VBoxContainer/TextureSelectButton
@onready var texture_file_line: LineEdit = $HBoxContainer/VBoxContainer2/TextureFileLine

var item_texture_paths: Array[String] = []

func _ready() -> void:
	if not FileAccess.file_exists(item_texture_paths_path):
		return
	
	var file: FileAccess = FileAccess.open(item_texture_paths_path, FileAccess.READ)
	item_texture_paths.append_array(file.get_csv_line())
	file.close()
	
	for item_texture_path: String in item_texture_paths:
		if FileAccess.file_exists(item_texture_path):
			texture_select_button.add_item(item_texture_path)
		else:
			print("Item texture path missing: " + item_texture_path)

func _on_create_item_button_pressed() -> void:
	
	if texture_select_button.selected == -1:
		push_warning("No texture for item selected")
		return
	
	var item_name: String = item_name_line.text.strip_edges().capitalize()
	
	if item_name.is_empty():
		push_warning("No item name given")
		return
	
	if DirAccess.get_directories_at(items_path).has(item_name.to_snake_case() + ".tscn"):
		push_warning("Item with name already exists")
		return
	
	# create item
	var item: Item = Item.new()
	item.name = item_name
	var texture: AtlasTexture = AtlasTexture.new()
	texture.atlas = load(texture_select_button.get_item_text(texture_select_button.selected))
	item.texture = texture
	ResourceSaver.save(item, items_path + item_name.to_snake_case() + ".tres")
	
	print("Created item: " + item_name)

func _on_add_texture_button_pressed() -> void:
	var item_texture_path: String = texture_file_line.text
	
	if item_texture_paths.has(item_texture_path):
		push_warning("Texture path already added: " + item_texture_path)
		return
	
	if not FileAccess.file_exists(item_texture_path):
		push_warning("Texture path does not exist: " + item_texture_path)
		return
	
	texture_select_button.add_item(item_texture_path)
	item_texture_paths.append(item_texture_path)

func _on_reload_textures_button_pressed() -> void:
	texture_select_button.clear()
	
	for item_texture_path: String in item_texture_paths:
		if FileAccess.file_exists(item_texture_path):
			texture_select_button.add_item(item_texture_path)
		else:
			item_texture_paths.erase(item_texture_path)

func _on_tree_exiting() -> void:
	print(item_texture_paths)
	
	var file = FileAccess.open(item_texture_paths_path, FileAccess.WRITE)
	file.store_csv_line(item_texture_paths)
	file.close()
