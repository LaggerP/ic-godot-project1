extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 200
var damage: float = 1

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		#TODO maybe is a good mechanic change the knockback if the player use different projectile
		body.knockback += direction * 90

#free projectile when it leaves the screen
func _on_screen_exited() -> void:
		queue_free()
