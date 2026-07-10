extends PanelContainer

const GOSLING_IMG = preload("uid://3noa1gmpsx54")

@onready var gosling_container: GridContainer = %GoslingContainer
@onready var add_gosling: Button = %AddGosling
@onready var remove_gosling: Button = %RemoveGosling
@onready var drop_bar: ProgressBar = %DropBar

@export var resources: Dictionary[Item, DropChance] = {}
@export var texture: Texture2D
@export var locked: bool = true
@export var time_to_drop: float = 10

const max_goslings: int = 9
var working_goslings: int = 0
var is_drop_bar_active: bool = false

func _process(delta: float) -> void:
	if not is_drop_bar_active:
		return
	
	drop_bar.value += (1 / time_to_drop) * delta
	if drop_bar.value >= 1:
		drop_bar.value = 0
		collect_drops()

func collect_drops() -> void:
	for item: Item in resources.keys():
		GM.add_item(item, resources[item].get_drop(working_goslings))

func unlock() -> void:
	if not locked:
		return
	
	locked = false
	add_gosling.disabled = false
	remove_gosling.disabled = false
	%LockIMG.queue_free()
	%AreaIMG.texture = texture

func _ready() -> void:
	if locked:
		add_gosling.disabled = true
		remove_gosling.disabled = true
	else:
		%LockIMG.queue_free()
		%AreaIMG.texture = texture

func _on_add_gosling_pressed() -> void:
	if GM.goslings_available == 0:
		return
	
	GM.goslings_available -= 1
	working_goslings += 1
	gosling_container.add_child(GOSLING_IMG.instantiate())
	remove_gosling.disabled = false
	if working_goslings == max_goslings:
		add_gosling.disabled = true
	
	if working_goslings == 1:
		start_progress_bar()

func _on_remove_gosling_pressed() -> void:
	GM.goslings_available += 1
	working_goslings -= 1
	remove_last_child(gosling_container)
	add_gosling.disabled = false
	if working_goslings == 0:
		remove_gosling.disabled = true
	
	if working_goslings == 0:
		stop_progress_bar()

func start_progress_bar() -> void:
	is_drop_bar_active = true

func stop_progress_bar() -> void:
	is_drop_bar_active = false
	drop_bar.value = 0

func remove_last_child(node: Node) -> void:
	node.remove_child(node.get_child(node.get_child_count() - 1))
