extends Control
@onready var click_sound: AudioStreamPlayer = $ClickSound

var CorrectSound = preload("res://assets/sounds/Menu Selection Click.wav")
func _on_start_pressed() -> void:
	if !click_sound.is_playing():
		click_sound.stream = CorrectSound
		click_sound.play()
	get_tree().change_scene_to_file("res://scenes/scene.tscn")

func _on_exit_pressed() -> void:
	if !click_sound.is_playing():
		click_sound.stream = CorrectSound
		click_sound.play()
	get_tree().quit() # default behavior

func _on_credits_pressed() -> void:
	if !click_sound.is_playing():
		click_sound.stream = CorrectSound
		click_sound.play()
	get_tree().change_scene_to_file("res://scenes/scene.tscn")
