extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed: float = 200
var damage: float = 1
@onready var arrow_sound: AudioStreamPlayer = $ArrowSound
var CorrectSound = preload("res://assets/sounds/weapons/arrow-impact.mp3")

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		reproduce_arrouw_sound()
		#TODO maybe is a good mechanic change the knockback if the player use different projectile
		body.knockback += direction * 90
		queue_free()

#free projectile when it leaves the screen
func _on_screen_exited() -> void:
		queue_free()
		
		
func reproduce_arrouw_sound():
	if !arrow_sound.is_playing():
		arrow_sound.stream = CorrectSound
		arrow_sound.play()
