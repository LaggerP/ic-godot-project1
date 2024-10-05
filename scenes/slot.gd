extends PanelContainer
@onready var label: Label = $Label

@export var weapon: Weapon:
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown

func _ready() -> void:
	$ProgressBar.max_value = weapon.cooldown

func _process(delta) -> void:
	if $ProgressBar.value == $ProgressBar.max_value:
		$ProgressBar.modulate = Color.SEA_GREEN
	$ProgressBar.value += delta
	

func _on_cooldown_timeout() -> void:
	if weapon:
		$Cooldown.wait_time = weapon.cooldown
		weapon.activate(owner, owner.enemy, get_tree())
		$ProgressBar.value = 0
		$ProgressBar.modulate = Color.RED
		
