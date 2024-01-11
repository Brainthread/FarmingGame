extends Camera2D

@export var target:Node2D
var target_former_position:Vector2 = Vector2()
var follow_speed:float = 1000
@export var look_ahead:bool = false
@export var min_point:Vector2 = Vector2(-9999999, -9999999)
@export var max_point:Vector2 = Vector2(9999999, 9999999)

# Called when the node enters the scene tree for the first time.
func _ready():
	target_former_position = target.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var target_heading = target.position - target_former_position
	var target_velocity = target_heading/delta
	
	if look_ahead == true:
		pass
	position = position.move_toward(target.position, follow_speed * delta)
	target_former_position = target.position
