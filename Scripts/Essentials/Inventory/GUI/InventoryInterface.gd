extends Control
class_name InventoryInterface

@onready var inventory_panel:InventoryPanel = $Inventory
@onready var grabbed_ui_slot:PanelContainer = $GrabbedSlot
@export var mouse_offset:Vector2 = Vector2(5,5)

var _is_active = false
var _is_initialized = false

var grabbed_slot: InventorySlot

func set_active(value:bool):
	_is_active = value

func _physics_process(delta):
	if grabbed_ui_slot.visible:
		grabbed_ui_slot.global_position = get_global_mouse_position() + mouse_offset

func on_inventory_interact(inventory: Inventory, index:int, button:int):
	print("%s %s %s" % [inventory, index, button])
	match [grabbed_slot, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.grab_slot(index)
			if grabbed_slot.stack_count > grabbed_slot.item_data.max_stack_size:
				#grabbed_slot.stack_count = grabbed_slot.item_data.max_stack_size
				print("Hmmmmm")
		[null, MOUSE_BUTTON_RIGHT]:
			print("What do you want me to do???")
			
		[_, MOUSE_BUTTON_LEFT]:
			var stackSpace = inventory.stack_space_for_item(index, grabbed_slot.item_data)
			if  stackSpace >= grabbed_slot.stack_count:
				inventory.add_item_to_slot(index, grabbed_slot.item_data, grabbed_slot.stack_count)
				grabbed_slot = null
			elif stackSpace > 0:
				inventory.add_item_to_slot(index, grabbed_slot.item_data, stackSpace)
				grabbed_slot.stack_count-=stackSpace
				if grabbed_slot.stack_count == 0:
					grabbed_slot = null
		[_, MOUSE_BUTTON_RIGHT]:
			if inventory.stack_space_for_item(index, grabbed_slot.item_data) > 0:
				inventory.add_item_to_slot(index, grabbed_slot.item_data, 1)
				grabbed_slot.stack_count-=1
				if grabbed_slot.stack_count == 0:
					grabbed_slot = null
				
	update_grabbed_slot()



func update_grabbed_slot():
	if grabbed_slot:
		grabbed_ui_slot.show()
		grabbed_ui_slot.set_slot_data(grabbed_slot)
	else:
		grabbed_ui_slot.hide()

func is_active():
	return is_active
	
func initialize():
	if not inventory_panel:
		push_error("No inventory UI assigned")
	inventory_panel.initialize()
	_is_initialized = true

func set_player_inventory_data(player_inventory:Inventory):
	if not _is_initialized:
		initialize()
	player_inventory.inventory_interact.connect(on_inventory_interact)
	inventory_panel.set_inventory_data(player_inventory)

func _ready():
	initialize()
