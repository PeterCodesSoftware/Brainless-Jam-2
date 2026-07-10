@tool
extends PanelContainer

const ITEMS_PATH = "res://game/item/items/"
const CRAFTS_PATH = "res://game/crafting/craft/crafts/"
const ITEM_IMG = preload("uid://c2s033jlw8hus")

@onready var item_container: GridContainer = %ItemContainer
@onready var craft_container: GridContainer = %CraftContainer
@onready var result_item: ItemIMG = %ResultItem
@onready var result_amount: SpinBox = %ResultAmount
@onready var selected_item_sprite: Sprite2D = %SelectedItemSprite

var craft_items: Array[ItemIMG] = []

var used_ingredient_strings: Dictionary[String, Item] = {}

var selected_item: Item:
	set(value):
		selected_item = value
		if value:
			selected_item_sprite.texture = value.texture

func _ready() -> void:
	# load items
	for item_name: String in DirAccess.get_files_at(ITEMS_PATH):
		var item_img: ItemIMG = ITEM_IMG.instantiate()
		item_img.show_preview = false
		item_img.item = load(ITEMS_PATH + item_name)
		item_img.left_clicked.connect(item_slot_left_clicked)
		item_container.add_child(item_img)
	
	# put crafting grid into array
	for node: Node in craft_container.get_children():
		craft_items.append(node as ItemIMG)
	
	# load crafts
	for craft_name: String in DirAccess.get_files_at(CRAFTS_PATH):
		var craft: Craft = load(CRAFTS_PATH + craft_name)
		used_ingredient_strings[craft.ingredient_string] = craft.product

func _process(delta: float) -> void:
	if not selected_item:
		selected_item_sprite.visible = false
		return
	
	var control: Control = get_viewport().gui_get_hovered_control()
	if control is ItemIMG:
		if control.show_preview == true:
			selected_item_sprite.visible = true
			selected_item_sprite.global_position = get_center(control)
		else:
			selected_item_sprite.visible = false
	elif control is GridContainer:
		selected_item_sprite.visible = false


func _on_create_craft_pressed() -> void:
	if result_item.item == null:
		push_error("No result item")
		return
	
	# check result dupe
	var craft_path: String = CRAFTS_PATH + result_item.item.name.to_snake_case() + ".tres"
	if FileAccess.file_exists(craft_path):
		push_error("Result already used in another craft: " + craft_path)
		return
	
	# create ingredient string
	var ingredient_string: String = ""
	for craft_item in craft_items:
		if craft_item.item:
			ingredient_string += craft_item.item.name
		else:
			ingredient_string += "."
	
	# check ingredient not empty
	if ingredient_string.length() <= 49:
		push_error("No ingredient items")
		return
	
	# check ingredient dupe
	if used_ingredient_strings.has(ingredient_string):
		push_error("Ingredient layout used in another craft: " + used_ingredient_strings[ingredient_string].name)
		return
	
	# create craft
	var craft: Craft = Craft.new()
	craft.result = result_item.item
	craft.amount = result_amount.value
	craft.ingredient_string = ingredient_string
	for craft_item: ItemIMG in craft_items:
		if craft_item.item:
			if craft.ingredients.has(craft_item.item):
				craft.ingredients[craft_item.item] += 1
			else:
				craft.ingredients[craft_item.item] = 1
	
	# save craft
	var error = ResourceSaver.save(craft, craft_path)
	if error != OK:
		push_error("Save craft error: " + error_string(error))
		return

func _on_craft_slot_left_clicked(item_img: ItemIMG) -> void:
	if selected_item == null:
		selected_item = item_img.item
	else:
		item_img.item = selected_item


func _on_craft_slot_right_clicked(item_img: ItemIMG) -> void:
	item_img.item = null


func item_slot_left_clicked(item_img: ItemIMG) -> void:
	selected_item = item_img.item

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			selected_item = null

func get_center(control: Control) -> Vector2:
	return control.global_position + control.size / 2


func _on_reset_craft_pressed() -> void:
	result_item.item = null
	result_amount.value = 1
	
	for craft_item: ItemIMG in craft_items:
		craft_item.item = null
