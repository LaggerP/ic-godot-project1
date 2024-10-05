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

func activate(_source, _target, _scene_tree):
	pass
