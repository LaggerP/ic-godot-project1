extends Resource
class_name Weapon

@export var title: String
@export var texture: Texture2D
@export var damage: float:
	set(value):
		damage = value
@export var cooldown: float
@export var speed: float
@export var projectile_node : PackedScene = null
@export var default_damage: float = damage
@export var knockback: float = 10
#this attribute allow to set a critical probability expressed in percentages (eg. 100 = 100%)
@export var critical_damage_probability: float = 0 

func activate(_source, _target, _scene_tree):
	pass

func is_critical_damage() -> bool:
	if critical_damage_probability < 0 or critical_damage_probability > 100: return false
	var random_value = randi() % 100
	return random_value < critical_damage_probability
