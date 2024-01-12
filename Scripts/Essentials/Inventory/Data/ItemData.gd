extends Resource
class_name ItemData

enum ItemType {
	Seedbag,
	Fruit,
	Wall_Decor,
	Floor_Decor,
}

@export var name: String
@export var icon: Texture2D
@export_multiline var description
@export var max_stack_size: int = 99
@export var value: int
@export var item_type:ItemType 
