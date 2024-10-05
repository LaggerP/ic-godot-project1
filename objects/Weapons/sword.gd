extends Node2D

var direction: Vector2 = Vector2.RIGHT
var damage: float = 10

func _on_enemy_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		#TODO maybe is a good mechanic change the knockback if the player use different weapon
		body.knockback += direction * 75
	
