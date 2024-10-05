extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree):
	if target == null: return
	
	#the range weapon instantiate the projectile. This projectile has damage logic
	var projectile = projectile_node.instantiate()
	
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.direction = (target.position - source.position).normalized()
	projectile.look_at(target.position)
	scene_tree.current_scene.add_child(projectile)


func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)
