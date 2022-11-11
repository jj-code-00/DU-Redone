extends KinematicBody2D

onready var sprite = $Sprite
onready var timer = $HitFlash
onready var timer1 = $KnockBack
var health = 10
var knock_back_by_damage = Vector2.ZERO

func _process(delta):
	if(health <= 0):
		queue_free()
func _physics_process(delta):
	if (!timer1.is_stopped()):
		move_and_slide(knock_back_by_damage)
	pass
func _take_damage(dmg):
	health -= dmg
	timer.start()
	sprite.modulate = Color.red
func _get_knocked_back(knock_back):
	knock_back_by_damage = knock_back
	timer1.start()
	
func _on_Timer_timeout():
	sprite.modulate = Color.white


func _on_KnockBack_timeout():
	timer1.stop()
