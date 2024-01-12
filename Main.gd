extends Node2D

@export var player_inventory: Inventory
@onready var player: CharacterBody2D = $Player
@onready var inventory_manager:PlayerInventoryManager = $Player/PlayerInventoryManager
@onready var inventory_interface: Control = $UI/InventoryHolder

func _ready():
	inventory_manager.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player_inventory)
	
func toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible
