extends PanelContainer

@onready var item:TextureRect = $MarginContainer/Item
@onready var quantity:Label = $Quantity


func set_slot_data(slot_data: InventorySlot) -> void:
	quantity.hide()
	var item_data = slot_data.item_data
	item.texture = item_data.icon
	tooltip_text = "%\n%" % [item_data.name, item_data.description]
	item.show()
	
	if slot_data.stack_count > 1:
		quantity.text = "x%s" % slot_data.stack_count
		quantity.show()
		
