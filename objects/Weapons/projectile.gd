extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float
var damage: float
var is_critical: bool
var knockback: float

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		$AnimationPlayer.play("hit")
		body.take_damage(damage, is_critical)
		body.knockback += direction * knockback

func _on_screen_exited() -> void:
		queue_free()
