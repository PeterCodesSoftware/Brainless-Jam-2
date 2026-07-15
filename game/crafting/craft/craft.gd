class_name Craft
extends Resource

static var crafts: Dictionary[String, Craft] = {}

@export var ingredient_string: String
@export var ingredients: Dictionary[Item, int] = {}
@export var result: Item
@export var amount: int = 1

func unlock() -> void:
	crafts[ingredient_string] = self
