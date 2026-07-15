class_name CraftDisplay
extends PanelContainer

@onready var grid_container: GridContainer = $GridContainer

@export var craft: Craft

func _ready() -> void:
	Item._static_init()
	
	var craft_ingredients: PackedStringArray = craft.ingredient_string.split("/")
	
	print(Item.items_by_name)
	for i: int in range(49):
		if craft_ingredients[i] == ".":
			continue
		var item: Item = Item.items_by_name[craft_ingredients[i]]
		var texture_rect: TextureRect = grid_container.get_child(i) as TextureRect
		texture_rect.texture = item.texture
