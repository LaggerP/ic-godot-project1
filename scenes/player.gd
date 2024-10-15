extends CharacterBody2D
class_name Player
@onready var sword: Node2D = %Sword

var enemy: CharacterBody2D
var nearest_enemy_distance: float = INF
var damage_popup_node = preload("res://scenes/damage.tscn")

@export var speed: float = 300
@export var health: float = 100:
	set(value):
		health = value
		%HealthBar.value = health
		if health <= 0:
			$AnimationPlayer.play("dead")
			GameManager.game_over()

func _ready() -> void:
	add_to_group("player_events")

func _physics_process(delta: float) -> void:
	if GameManager.can_upgrade:
		set_upgrades()
		GameManager.can_upgrade = false
		
	if is_instance_valid(enemy):
		nearest_enemy_distance = enemy.separation
	else:
		nearest_enemy_distance = INF
	
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_collide(velocity * delta)
	
	sword.rotation = mouse_direction.angle()
	if sword.scale.y == 1 and mouse_direction.x < 0:
		sword.scale.y = -1
	elif sword.scale.y == -1 and mouse_direction.x > 0:
		sword.scale.x = 1

func take_damage(enemy_damage):
	$AnimationPlayer.play("hurt")
	health -= enemy_damage
	damage_popup(enemy_damage)

func damage_popup(amount):
	var pop = damage_popup_node.instantiate()
	pop.text = str(ceil(amount))
	pop.position = position + Vector2(-50,-25)
	pop.modulate = Color.RED
	get_tree().current_scene.add_child(pop)

func _on_take_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)
	
func increase_temporal_damage() -> void:
	sword.damage = sword.damage * 2
	var node = $WeaponInventory/Weapons
	for N in node.get_children():
		if "weapon" in N:
			var weapon_slot = N.weapon as SingleShot
			weapon_slot.damage += 10
	$DamageCooldown.start()

func _on_damage_cooldown_timeout() -> void:
	$DamageCooldown.stop()
	sword.damage = sword.damage / 2
	var node = $WeaponInventory/Weapons
	for N in node.get_children():
		if "weapon" in N:
			var weapon_slot = N.weapon as SingleShot
			weapon_slot.damage =  weapon_slot.default_damage

func set_upgrades():
	var upgrades = GameManager.get_weapon_upgrades()
	var node = $WeaponInventory/Weapons
	for key in upgrades:
		match key:
			"increment_damage":
				if upgrades[key]:
					sword.damage += 10
					for N in node.get_children():
						if "weapon" in N:
							var weapon_slot = N.weapon as SingleShot
							weapon_slot.damage += 10
			"increment_velocity":
				if upgrades[key]:
					for N in node.get_children():
						if "weapon" in N:
							var weapon_slot = N.weapon as SingleShot
							weapon_slot.speed += 100
			"decrement_cooldown":
				if upgrades[key]:
					for N in node.get_children():
						if "weapon" in N:
							var weapon_slot = N.weapon as SingleShot
							weapon_slot.cooldown = weapon_slot.cooldown * 0.9
