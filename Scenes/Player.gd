extends KinematicBody2D

var speed = 300
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var fist_collision = $Area2D/CollisionShape2D

onready var animation_state = animation_tree.get("parameters/playback")
var movement = Vector2.ZERO
var blend = Vector2.ZERO
var is_flying = true
var damage = 2
var knock_back = Vector2.ZERO

func _physics_process(_delta):
	if movement != Vector2.ZERO:
		blend = movement.normalized()
		animation_tree.set("parameters/Idle/blend_position", blend)
		animation_tree.set("parameters/Walk/blend_position", blend)
		animation_tree.set("parameters/Attacking/blend_position", blend)
	_get_input()
	
func _get_input():
	if(Input.is_action_pressed("i_up")):
		print("Pressed W")
		movement = Vector2(0,-1*speed)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(Input.is_action_pressed("i_down")):
		print("Pressed S")
		movement = Vector2(0,1*speed)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(Input.is_action_pressed("i_left")):
		print("Pressed A")
		movement = Vector2(-1*speed,0)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(Input.is_action_pressed("i_right")):
		print("Pressed D")
		movement = Vector2(1*speed,0)
		animation_state.travel("Walk")
		move_and_slide(movement)
		
	if(!(Input.is_action_pressed("i_up") || Input.is_action_pressed("i_down") || Input.is_action_pressed("i_left") || Input.is_action_pressed("i_right") || Input.is_action_pressed("i_punch"))):
		animation_state.travel("Idle")
		
	if(Input.is_action_just_pressed("i_toggle_flight")):
		print("Pressed R")
		is_flying = !is_flying
		set_collision_mask_bit(1,is_flying)
		set_collision_mask_bit(0,is_flying)
		
	if(Input.is_action_just_pressed("i_punch")):
		print("Pressed SPACE")
		knock_back = blend * 1000 * damage
		animation_state.travel("Attacking")
		
func _on_Area2D_body_entered(body):
	if (body.is_in_group("enemy")):
		body._take_damage(damage)
		body._get_knocked_back(knock_back)
