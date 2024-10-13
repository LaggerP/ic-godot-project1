extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree):
	if target == null: return
	
	#the range weapon instantiate the projectile. This projectile has damage logic
	var projectile = projectile_node.instantiate()
	projectile.is_critical = is_critical_damage()
	projectile.position = source.position
	if projectile.is_critical:
		projectile.damage = damage * 1.1
	else:
		projectile.damage = damage
		
	projectile.speed = speed
	projectile.knockback = knockback
	projectile.direction = (target.position - source.position).normalized()
	projectile.look_at(target.position)
	scene_tree.current_scene.add_child(projectile)


func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)
