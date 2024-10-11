extends Enemy

func _ready() -> void:
	$Sprite2D.material = load("res://Shaders/Rainbow.tres") #load Rainbow shader if the enemy has elite flag in true
	scale = Vector2(1.5,1.5)
