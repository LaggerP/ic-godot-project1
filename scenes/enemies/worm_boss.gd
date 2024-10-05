extends CharacterBody2D

@export var enemy_data: Enemy

var player_ref: CharacterBody2D #store direction and speed from player
var damage_popup_node = preload("res://scenes/damage.tscn")
var direction: Vector2
var knockback: Vector2
var separation: float #separation between enemy and player


func _ready() -> void:
	$Sprite2D.texture = enemy_data.texture
	$Sprite2D.material = load("res://Shaders/Rainbow.tres") #load Rainbow shader if the enemy has elite flag in true
	scale = Vector2(1.5,1.5)
		
func _physics_process(delta: float) -> void:
	if is_instance_valid(player_ref):
		check_separation(delta)
		knockback_update(delta)
	
func check_separation(_delta):
	if is_instance_valid(player_ref):
		separation = (player_ref.position - position).length() #get enemy distance from player
		if separation >= 500 and not enemy_data.Type.ELITE:
			queue_free()
		if separation < player_ref.nearest_enemy_distance:
			player_ref.enemy = self
		
func knockback_update(delta):
		velocity = (player_ref.position - position).normalized() * enemy_data.speed
		knockback = knockback.move_toward(Vector2.ZERO, 1)
		velocity += knockback
		var collider = move_and_collide(velocity * delta)
		if collider:
			collider.get_collider().knockback = (collider.get_collider().global_position - global_position).normalized() * 50
			
func damage_popup(amount, is_critical = false):
	var pop = damage_popup_node.instantiate()
	pop.text = str(amount)
	pop.position = position + Vector2(-50,-25)
	if is_critical:
		pop.modulate = Color.YELLOW
	get_tree().current_scene.add_child(pop)
	
func take_damage(enemy_damage):
	$EnemyAnimationPlayer.play("hit")
	#TODO this method is not good enough. Check another way to implement this. Its only for static damage
	damage_popup(enemy_damage, enemy_damage >= 10)
	enemy_data.health -= enemy_damage
	if enemy_data.health <= 0:
		get_tree().call_group("enemy_events", "on_enemy_dead")
		var drop: bool = randi_range(0, 1)
		if drop:
			drop_item()
		queue_free()

func drop_item():
	var item = enemy_data.drop_item()
	if item:
		get_tree().root.add_child.call_deferred(item)
		item.global_position = global_position


#only for elite enemies
func _on_attack_area_body_entered(body: Node2D) -> void:
	print(body)
	pass # Replace with function body.
