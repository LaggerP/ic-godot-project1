extends Area2D

@export var value: int = 10:
	set(v):
		value = v

func _process(_delta: float) -> void:
	$Animation.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.health <= 100:
		body.health += value
	queue_free()
