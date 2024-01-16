extends Control
class_name InventoryInterface

@onready var inventory_panel:InventoryPanel = $Inventory/InventoryPanel
@onready var inventory_holder:Node2D = $Inventory
@onready var hotbar_panel = $Hotbar
@onready var grabbed_ui_slot:PanelContainer = $Inventory/GrabbedSlot
@export var mouse_offset:Vector2 = Vector2(5,5)

var _is_active = false
var _is_initialized = false

var grabbed_slot: InventorySlot = InventorySlot.new()

func set_active(value:bool):
	_is_active = value

func _process(delta):
	if grabbed_ui_slot.visible:
		grabbed_ui_slot.global_position = get_global_mouse_position() + mouse_offset

func on_inventory_interact(inventory: Inventory, index:int, button:int):
	match [grabbed_slot.item_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.grab_slot(index)
		[null, MOUSE_BUTTON_RIGHT]:
			print("What do you want me to do???")
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.drop_slot(index, grabbed_slot)
		[_, MOUSE_BUTTON_RIGHT]:
			if inventory.stack_space_for_item(index, grabbed_slot.item_data) > 0:
				inventory.add_item_to_slot(index, grabbed_slot.item_data, 1)
				grabbed_slot.stack_count-=1
				if grabbed_slot.stack_count == 0:
					grabbed_slot.item_data = null
	update_grabbed_slot()

func set_slot_background_icon(index:int, icon:Texture2D):
	inventory_panel.set_slot_background_icon(index, icon)
	
func update_grabbed_slot():
	if grabbed_slot.item_data:
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

func toggle_inventory_holder_visibility():
	inventory_holder.visible = not inventory_holder.visible
	
func toggle_hotbar_visibility():
	hotbar_panel.visible = not hotbar_panel.visible

func set_player_inventory_data(player_inventory:Inventory):
	if not _is_initialized:
		initialize()
	player_inventory.inventory_interact.connect(on_inventory_interact)
	inventory_panel.set_inventory_data(player_inventory)
	hotbar_panel.set_inventory_data(player_inventory)



func _ready():
	initialize()