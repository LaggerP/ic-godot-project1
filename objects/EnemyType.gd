extends Resource
class_name Enemy

enum Type {NORMAL, ELITE, LEGENDARY}

@export var title: String
@export var texture: Texture2D
@export var health: float
@export var damage: float
@export var type: Type
@export var speed: float
@export var drop_items: Array[PackedScene] = []

func drop_item():
	if drop_items.is_empty(): return 
	return drop_items.pick_random().instantiate()

	
	
