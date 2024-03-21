extends Resource
class_name ItemLibrary

@export var items:Array[ItemData]

func get_item (id:int) -> ItemData:
	if id < 0 or id > items.size():
		return null
	else:
		return items[id]
