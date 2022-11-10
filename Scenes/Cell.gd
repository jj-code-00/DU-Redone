extends KinematicBody2D

onready var sprite = $Sprite
var health = 10

func _process(delta):
	if(health <= 0):
		queue_free()
func _take_damage(dmg):
	health -= dmg
	sprite.modulate = Color.red
	yield(get_tree().create_timer(.2),"timeout")
	sprite.modulate = Color.white
	
