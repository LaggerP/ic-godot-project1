extends Area2D

@export var value: int = 10:
	set(v):
		value = v

func _process(_delta: float) -> void:
	$Animation.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("increase_temporal_damage"):
		body.increase_temporal_damage()
	queue_free()
