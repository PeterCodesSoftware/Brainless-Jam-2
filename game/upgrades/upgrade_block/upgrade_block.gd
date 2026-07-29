class_name UpgradeBlock
extends PanelContainer

const ITEM_SLOT = preload("uid://c2jmlhx0po8ey")

@onready var cost_container: GridContainer = %CostContainer

@export var upgrade_action: UpgradeAction
@export var costs: Dictionary[Item, int]
@export var dependency_paths: Array[NodePath] = []

signal bought

var unlocked: bool = false
var dependencies_left: int = 0

func _ready() -> void:
	if not costs.is_empty():
		%FreeLabel.queue_free()
	
	for item: Item in costs:
		var item_slot: ItemSlot = ITEM_SLOT.instantiate()
		item_slot.item = item
		item_slot.amount = costs[item]
		cost_container.add_child(item_slot)
	
	if dependency_paths.is_empty():
		unlock()
	else:
		dependencies_left = dependency_paths.size()
		for dependency_path: NodePath in dependency_paths:
			var dependecy: UpgradeBlock = get_node(dependency_path) as UpgradeBlock
			dependecy.bought.connect(dependency_bought)
	
	

func dependency_bought() -> void:
	dependencies_left -= 1
	if dependencies_left == 0:
		unlock()

func unlock() -> void:
	unlocked = true
	%Buy.disabled = false

func _on_buy_pressed() -> void:
	for item: Item in costs:
		if not (GM.inventory.has(item) and GM.inventory[item] >= costs[item]):
			return
	
	for item: Item in costs:
		GM.remove_item(item, costs[item])
	
	bought.emit()
	upgrade_action.upgrade()
	%Buy.disabled = true

func _draw() -> void:
	for dependency_path: NodePath in dependency_paths:
		var dependecy: Control = get_node(dependency_path)
		draw_line(size / 2, dependecy.global_position + dependecy.size / 2 - global_position, Color.WHITE)
