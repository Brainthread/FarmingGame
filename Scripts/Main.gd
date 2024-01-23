extends Node2D

var player_inventory: Inventory
@onready var player: CharacterBody2D = $Player
@onready var inventory_manager:PlayerInventoryManager = $Player/PlayerInventoryManager
@onready var inventory_interface: Control = $UI/InventoryHolder

@export var trash_icon:Texture2D
@export var hotbar_icon:Texture2D

@onready var player_build_manager = $Player/PlayerInventoryManager/ItemInteractionManager/Placement
@onready var world_build_handler:BuildHandler = $WorldGrid/BuildHandler

func _ready():
	inventory_interface.toggle_hotbar_visibility()
	player_inventory = inventory_manager.inventory
	player_inventory.initialize_inventory()
	
	inventory_manager.set_active_inventory_slot.connect(inventory_interface.on_set_active_inventory_item)
	inventory_manager.toggle_inventory.connect(toggle_inventory_interface)
	inventory_manager.set_inventory_and_hotbar_visibility.connect(set_inventory_visibility)
	
	inventory_interface.initialize(player_inventory)
	
	player_build_manager.world_build_handler = world_build_handler
	_set_inventory_icons()
	
	
func _set_inventory_icons():
	for i in 5:
		inventory_interface.set_slot_background_icon(i, hotbar_icon)

func reload_inventory():
	pass
	#inventory_interface.set_player_inventory_data(player_inventory)
	#inventory_interface.set_trash_inventory_data()
	#_set_inventory_icons()

func toggle_inventory_interface():
	inventory_interface.toggle_inventory_holder_visibility()
	inventory_interface.toggle_hotbar_visibility()
	reload_inventory()
	
func set_inventory_visibility(value: bool):
	inventory_interface.set_inventory_visibility(value)
	reload_inventory()
