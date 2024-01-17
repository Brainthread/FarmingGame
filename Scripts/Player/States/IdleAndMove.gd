extends State

var _input_direction = Vector2()
var _input_sprint:bool = false
var _body:CharacterBody2D
@export var _movement_speed:float = 10000
@export var _acceleration:float = 10000
@export var _sprint_multiplier:float = 2
@export var _direction_change_modifier = 3
var _movement_velocity:Vector2 = Vector2()

@onready var player_inventory_manager = $"../../PlayerInventoryManager"
@export var _battle_mode:bool = false

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
	_handle_actions(_delta)
	pass

func _state_physics_update(_delta: float):
	_move_character(_delta)
	pass


func _handle_input():
	_input_direction = Vector2(
			Input.get_action_strength("Right") - Input.get_action_strength("Left"), 
			Input.get_action_strength("Down") - Input.get_action_strength("Up"))
	_input_direction = _input_direction.normalized()
	_input_sprint = true if Input.get_action_strength("Sprint") else false
	if Input.is_action_just_pressed("Combat Mode"):
		_toggle_combat_mode()
		

func _toggle_combat_mode():
	_battle_mode = not _battle_mode
	player_inventory_manager.set_inventory_availability(not _battle_mode)

func _move_character(_delta: float):
	var _direction_change_coefficient = 1
	var _sprint_coefficent = _sprint_multiplier if _input_sprint else 1
	if _movement_velocity.dot(_input_direction) < 0 and not _movement_velocity == Vector2.ZERO and not _input_direction == Vector2.ZERO:
		_direction_change_coefficient = _direction_change_modifier
	
	var _target_velocity = _input_direction * _movement_speed * _sprint_coefficent
	var _point_acceleration = _delta * _acceleration * _direction_change_coefficient
	_movement_velocity = _movement_velocity.move_toward(_target_velocity, _point_acceleration)
	
	_body.velocity = _delta * _movement_velocity
	_body.move_and_slide()
	
func _handle_actions(_delta: float):
	if _battle_mode:
		pass
	else:
		pass
	

