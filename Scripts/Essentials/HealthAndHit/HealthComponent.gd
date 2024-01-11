extends Node
class_name HealthComponent

@export var max_health:float = 10
@export var health:float = 10

var sent_depletion_signal = false
signal health_depleted

func _ready():
	health = max_health

func get_health():
	return health

func get_max_health():
	return max_health

func apply_damage(damage):
	health -= damage
	if health <= 0:
		health = 0
		if sent_depletion_signal == false:
			sent_depletion_signal = true
			health_depleted.emit()

func heal(healing):
	health += healing
	if health > max_health:
		health = max_health

