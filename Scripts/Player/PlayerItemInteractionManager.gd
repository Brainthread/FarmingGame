extends Node

@onready var placementManager = $Placement
var held_item:InventorySlot
var held_state:PlayerItemInteraction


func on_held_item_update(itemSlot:InventorySlot):
	if held_state:
		held_state.stop_holding()
	held_item = itemSlot
	if held_item && held_item.item_data:
		if held_item.item_data is Placeable \
				or held_item.item_data is Seedbag:
				held_state = placementManager
		if held_state:
			held_state.item = held_item
			held_state.start_holding()


func _process(_delta):
	hold_item(held_item)

func hold_item(itemSlot:InventorySlot):
	if itemSlot:
		if itemSlot.item_data:
			holding_valid_item(itemSlot)
	else:
		pass
		
func holding_valid_item(_itemSlot:InventorySlot):
	if held_state:
		held_state.holding_update()

func _input(_event):
		if _event is InputEventMouseButton and \
				_event.button_index == MOUSE_BUTTON_LEFT and \
				held_state:
			held_state.use()

