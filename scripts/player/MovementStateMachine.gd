extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(_on_child_transition)
			child.player = get_parent()
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)


func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)


func _on_child_transition(new_state_name: String):
	var new_state = states.get(new_state_name.to_lower())
	if !new_state or new_state == current_state:
		return
	
	current_state.exit()
	new_state.enter()
	current_state = new_state
	
