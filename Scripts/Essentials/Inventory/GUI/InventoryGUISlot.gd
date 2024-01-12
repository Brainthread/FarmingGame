extends PanelContainer

signal slot_clicked(index: int, button:int)

@onready var item:TextureRect = $MarginContainer/Item
@onready var quantity:Label = $Quantity

func initialize():
	item = $MarginContainer/Item
	quantity = $Quantity

func set_slot_data(slot_data: InventorySlot) -> void:
	quantity.hide()
	var item_data = slot_data.item_data
	item.texture = item_data.icon
	tooltip_text = "%\n%" % [item_data.name, item_data.description]
	item.show()
	print(slot_data.stack_count)
	if slot_data.stack_count > 1:
		quantity.text = "x%s" % slot_data.stack_count
		quantity.show()
		

func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
