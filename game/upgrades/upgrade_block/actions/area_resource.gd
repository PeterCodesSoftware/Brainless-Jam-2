class_name AreaResource
extends UpgradeAction

@export var area: Area
@export var item: Item
@export var drop_chance: DropChance

func upgrade() -> void:
	area.resources[item] = drop_chance
