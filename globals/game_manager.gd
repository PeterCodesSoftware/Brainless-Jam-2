extends Node

var inventory: Dictionary[Item, int] = {}

@warning_ignore("unused_signal")
signal display_popup(node: Node)

signal goslings_available_changed
signal update_item_slot(item: Item)
signal create_item_slot(item: Item)

var goslings_available: int = 1:
	set(value):
		goslings_available = value
		goslings_available_changed.emit()

func add_item(item: Item, amount: int) -> void:
	if amount == 0:
		return
	
	if inventory.has(item):
		inventory[item] += amount
		update_item_slot.emit(item)
	else:
		inventory[item] = amount
		create_item_slot.emit(item)

func remove_item(item: Item, amount: int) -> void:
	if amount == 0:
		return
	
	if (not inventory.has(item)) or inventory[item] < amount:
		push_error(
			"invalid remove item call:
			\nItem: " + item.name + 
			"\nAmount: " + str(inventory[item]) + 
			"\nRemove: " + str(amount)
		)
		return
	
	inventory[item] -= amount
	update_item_slot.emit(item)
