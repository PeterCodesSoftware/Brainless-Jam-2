extends Control

@onready var inventory_container: GridContainer = %InventoryContainer

const ITEM_SLOT = preload("uid://c2jmlhx0po8ey")

var slots: Dictionary[Item, ItemSlot]

func _ready() -> void:
	GM.create_item_slot.connect(create_slot)
	GM.update_item_slot.connect(update_slot)

func create_slot(item: Item) -> void:
	var item_slot: ItemSlot = ITEM_SLOT.instantiate()
	item_slot.item = item
	item_slot.amount = GM.inventory[item]
	inventory_container.add_child(item_slot)
	slots[item] = item_slot

func update_slot(item: Item) -> void:
	slots[item].amount = GM.inventory[item]

func _on_search_text_changed(new_text: String) -> void:
	var item_slots: Array[Node] = inventory_container.get_children()
	new_text = new_text.to_lower()
	for item_slot: ItemSlot in item_slots:
		item_slot.visible = item_slot.item.name.to_lower().substr(0, new_text.length()) == new_text

func sort_item_slots(sort_func: Callable) -> void:
	var item_slots: Array[Node] = inventory_container.get_children()
	item_slots.sort_custom(sort_func)
	for item_slot in item_slots:
		inventory_container.move_child(item_slot, inventory_container.get_child_count() - 1)

func sort_alphabetical(a: ItemSlot, b: ItemSlot) -> bool:
	return a.item.name.casecmp_to(b.item.name) < 0

func sort_amount(a: ItemSlot, b: ItemSlot) -> bool:
	if a.amount == b.amount:
		return sort_alphabetical(a, b)
	else:
		return a.amount < b.amount
