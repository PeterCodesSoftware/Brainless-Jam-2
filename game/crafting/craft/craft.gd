class_name Craft
extends Resource

static var crafts: Dictionary[String, Item] = {}

@export var ingredient_string: String
@export var ingredients: Dictionary[Item, int] = {}
@export var result: Item
@export var amount: int = 1
