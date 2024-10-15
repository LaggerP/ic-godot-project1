extends Node2D

var direction: Vector2 = Vector2.RIGHT
var damage: float = 10
var default_damage: float = damage
var critical_damage_probability: float = 1

func _on_enemy_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		var critial_damage = is_critical_damage()
		if critial_damage:
			damage = damage * 1.1
		body.take_damage(damage, critial_damage)
		#TODO maybe is a good mechanic change the knockback if the player use different weapon
		body.knockback += direction * 75
		damage = damage * 0.9
	

func is_critical_damage() -> bool:
	if critical_damage_probability < 0 or critical_damage_probability > 100: return false
	var random_value = randi() % 100
	return random_value < critical_damage_probability
