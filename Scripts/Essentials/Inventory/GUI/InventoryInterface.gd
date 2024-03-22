extends Control
class_name InventoryInterface

@onready var inventory_panel:InventoryPanel = $Inventory/InventoryPanel
@onready var inventory_holder:Node2D = $Inventory
@onready var grabbed_ui_slot:PanelContainer = $Inventory/GrabbedSlot
@onready var trash_panel:PanelContainer = $Inventory/TrashPanel
@onready var hotbar_panel = $Inventory/Hotbar

@onready var hotbar_inventory:Inventory

@export var mouse_offset:Vector2 = Vector2(5,5)
@export var selected_hotbar_icon:Texture2D
@export var trash_icon:Texture2D

var trash_inventory:Inventory

var inventories:Array[Inventory]
var inventorypanel:Array[InventoryPanel]

var _is_active = true
var _is_initialized = false
var active_item_index = -1

var grabbed_slot: InventorySlotData = InventorySlotData.new()
var _former_grabbed_slot:InventorySlotData


func initialize(main_inventory:Inventory):
	if not inventory_panel:
		push_error("No inventory UI assigned")
	inventory_panel.initialize()
	trash_panel.initialize()
	_is_initialized = true
	initialize_trash()
	main_inventory.inventory_interact.connect(on_inventory_interact)
	set_player_inventory_data(main_inventory)
	set_trash_inventory_data()

func initialize_trash():
	if not trash_inventory:
		trash_inventory = Inventory.new()
		trash_inventory.initialize_empty_inventory(1)
	trash_inventory.inventory_interact.connect(on_inventory_interact)

func _process(_delta):
	if grabbed_ui_slot.visible:
		grabbed_ui_slot.global_position = get_global_mouse_position() + mouse_offset

func set_panel_background_icon(panel:PanelContainer, index:int, icon:Texture2D):
	panel.set_slot_background_icon(index, icon)

#Could be outsourced to a hotbar-script
func on_set_active_inventory_item(index:int):
	if active_item_index >= 0:
		set_hotbar_background_icon(active_item_index, null)
	if index >= 0:
		set_hotbar_background_icon(index, selected_hotbar_icon)
	active_item_index = index

func _exit_inventory_panel():
	if grabbed_slot.item_data and _former_grabbed_slot:
		if _former_grabbed_slot.item_data == grabbed_slot.item_data:
			var addable = grabbed_slot.item_data.max_stack_size - _former_grabbed_slot.stack_count
			_former_grabbed_slot.stack_count = min(grabbed_slot.stack_count, addable)
			grabbed_slot.stack_count = max(grabbed_slot.stack_count-addable, 0) 
		if not _former_grabbed_slot.item_data:
			_former_grabbed_slot.item_data = grabbed_slot.item_data
			_former_grabbed_slot.stack_count = grabbed_slot.stack_count
		grabbed_slot.item_data = null
		_former_grabbed_slot.update_slot()
	update_grabbed_slot()
	pass

#handle click interaction with inventory
func on_inventory_interact(inventory: Inventory, index:int, button:int):
	match [grabbed_slot.item_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot = inventory.grab_slot(index)
			_former_grabbed_slot = inventory.get_slot(index)
		[null, MOUSE_BUTTON_RIGHT]:
			print("What do you want me to do???")
		[_, MOUSE_BUTTON_LEFT]:
			if inventory == trash_inventory && inventory.stack_space_for_item(index, grabbed_slot.item_data) == 0:
				inventory.clear_slot(index)
			grabbed_slot = inventory.drop_slot(index, grabbed_slot)
		[_, MOUSE_BUTTON_RIGHT]:
			inventory.drop_single_item(index, grabbed_slot)
			if grabbed_slot.stack_count == 0:
				grabbed_slot.item_data = null
	update_grabbed_slot()

func set_slot_background_icon(index:int, icon:Texture2D):
	inventory_panel.set_slot_background_icon(index, icon)

func set_hotbar_background_icon(index:int, icon:Texture2D):
	hotbar_panel.set_slot_background_icon(index, icon)

func update_grabbed_slot():
	if grabbed_slot.item_data:
		grabbed_ui_slot.show()
		grabbed_ui_slot.set_slot_data(grabbed_slot)
	else:
		grabbed_ui_slot.hide()

func is_active():
	return is_active

func toggle_inventory_holder_visibility():
	if _is_active:
		inventory_holder.visible = not inventory_holder.visible
		if inventory_holder.visible == false:
			_exit_inventory_panel()
	
func toggle_hotbar_visibility():
	if _is_active:
		hotbar_panel.visible = not hotbar_panel.visible
	
func set_inventory_visibility(value:bool):
	inventory_holder.visible = value
	hotbar_panel.visible = value
	_is_active = value
	if _is_active:
		toggle_inventory_holder_visibility()

func set_trash_inventory_data():
	set_inventory_data(trash_inventory, trash_panel)
	trash_panel.set_slot_background_icon(0, trash_icon)

func set_player_inventory_data(player_inventory:Inventory):
	set_inventory_data(player_inventory, inventory_panel)
	hotbar_panel.set_inventory_data(player_inventory)

func set_inventory_data(inventory: Inventory, target_panel:InventoryPanel):
	target_panel.set_inventory_data(inventory)

func save_inventory ():
	#Save Main
	#Save Auxiliary
	pass


