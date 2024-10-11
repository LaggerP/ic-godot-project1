class_name Enemy
extends CharacterBody2D

enum Type {NORMAL, ELITE, LEGENDARY}

var player_ref: CharacterBody2D #store direction and speed from player. Setted on Enemy instance
@export var health: float
@export var damage: float
@export var type: Type
@export var speed: float
@export var drop_items: Array[PackedScene] = []

var damage_popup_node = preload("res://scenes/damage.tscn")
var direction: Vector2
var knockback: Vector2
var separation: float #separation between enemy and player

func _physics_process(delta: float) -> void:
	#if Enemy has an animation with name walk, reproduce that animation every frame.
	if $EnemyAnimationPlayer.current_animation == "":
		$EnemyAnimationPlayer.play("walk")
	if is_instance_valid(player_ref):
		check_separation(delta)
		knockback_update(delta)
	
func check_separation(_delta):
	if is_instance_valid(player_ref):
		separation = (player_ref.position - position).length() #get enemy distance from player
		if separation >= 500 and not Type.ELITE:
			queue_free()
		if separation < player_ref.nearest_enemy_distance:
			player_ref.enemy = self
		
func knockback_update(delta):
		velocity = (player_ref.position - position).normalized() * speed
		knockback = knockback.move_toward(Vector2.ZERO, 1)
		velocity += knockback
		var collider = move_and_collide(velocity * delta)
		#this is a hack to prevent an enemy do a knockback with the decorations
		if collider and collider.get_collider().get_class() != "TileMapLayer":
			collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
			
func damage_popup(amount, is_critical):
	var pop = damage_popup_node.instantiate()
	pop.text = str(amount)
	pop.position = position + Vector2(-50,-25)
	if is_critical:
		pop.modulate = Color.YELLOW
	get_tree().current_scene.add_child(pop)
	
func take_damage(enemy_damage, is_critical = false):
	$EnemyAnimationPlayer.play("hit")
	damage_popup(enemy_damage, is_critical)
	health -= enemy_damage
	if health <= 0:
		get_tree().call_group("enemy_events", "on_enemy_dead")
		var drop: bool = randi_range(0, 1)
		if drop:
			drop_item()
		queue_free()

func drop_item():
	if drop_items.is_empty(): return 
	var item = drop_items.pick_random().instantiate()
	get_tree().root.add_child.call_deferred(item)
	item.global_position = global_position

	
	
	
