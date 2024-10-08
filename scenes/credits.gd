extends Control

@onready var click_sound: AudioStreamPlayer = $ClickSound
const MENU_SELECTION_CLICK = preload("res://assets/sounds/MenuSelectionClick.wav")


func _on_button_pressed() -> void:
	reproduce_click_sound()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func reproduce_click_sound():
	if !click_sound.is_playing():
		click_sound.stream = MENU_SELECTION_CLICK
		click_sound.play()
