extends Label

func _ready(): 
	pop_damage()

func pop_damage():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2,2), .3)
	tween.chain().tween_property(self, "scale", Vector2(1,1), .3)
	await tween.finished
	queue_free()
