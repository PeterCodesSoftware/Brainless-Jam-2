class_name StateMachine
extends Node

@export var initial_state: State

@onready var state: State = initial_state


func _ready() -> void:
	for state_node: State in get_children():
		state_node.switch_state.connect(switch_state)
	
	await owner.ready
	state.enter("") # if error here, you forgot to set a initial state


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func switch_state(next_state_path: String) -> void:
	if not has_node(next_state_path):
		printerr(owner.name + ": Trying to transition to state " + next_state_path + " but it does not exist.")
		return
	
	var previous_state_path: String = state.name
	state.exit(next_state_path)
	state = get_node(next_state_path)
	state.enter(previous_state_path)
