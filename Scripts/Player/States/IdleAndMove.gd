extends State

var _input_direction = Vector2()
var _body:CharacterBody2D
@export var _movement_speed:float = 10000

func _initialize_state(stateMachine_node:FiniteStateMachine, root_node:Node2D):
	super(stateMachine_node, root_node)
	if not root is CharacterBody2D:
		push_error("Root node is not Character Body")
	_body = root as CharacterBody2D

func _enter_state():
	pass

func _exit_state():
	pass

func _state_update(_delta: float):
	_handle_input()
	pass

func _state_physics_update(_delta: float):
	_move_character(_delta)
	pass

func _handle_input():
	_input_direction = Vector2(
			Input.get_action_strength("Right") - Input.get_action_strength("Left"), 
			Input.get_action_strength("Down") - Input.get_action_strength("Up"))

func _move_character(_delta: float):
	_body.velocity = _movement_speed * _delta * _input_direction
	_body.move_and_slide()
