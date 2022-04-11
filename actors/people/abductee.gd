extends KinematicBody2D

const SPEED = -80
const UP = Vector2(0, -1)
const slide = Vector2(0,0)

var in_gravity_beam = false
var abductee_speed = Vector2(0, 0)

var model0 = preload("res://assets/UFO Main/female1.png")
var model1 = preload("res://assets/UFO Main/female2.png")
var model2 = preload("res://assets/UFO Main/female3.png")
var model3 = preload("res://assets/UFO Main/female4.png")
var model4 = preload("res://assets/UFO Main/female5.png")
var model5 = preload("res://assets/UFO Main/male1.png")
var model6 = preload("res://assets/UFO Main/male2.png")
var model7 = preload("res://assets/UFO Main/male3.png")
var model8 = preload("res://assets/UFO Main/male4.png")
var model9 = preload("res://assets/UFO Main/male5.png")

func _ready() -> void:
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, 9)
	
	if num == 0:
		$Area2D/Sprite.set_texture(model0)
	elif num == 1: 
		$Area2D/Sprite.set_texture(model1)
	elif num == 2: 
		$Area2D/Sprite.set_texture(model2)
	elif num == 3: 
		$Area2D/Sprite.set_texture(model3)
	elif num == 4: 
		$Area2D/Sprite.set_texture(model4)
	elif num == 5: 
		$Area2D/Sprite.set_texture(model5)
	elif num == 6: 
		$Area2D/Sprite.set_texture(model6)
	elif num == 7: 
		$Area2D/Sprite.set_texture(model7)
	elif num == 8: 
		$Area2D/Sprite.set_texture(model8)
	else: 
		$Area2D/Sprite.set_texture(model9)

func _physics_process(delta: float) -> void:
	set_gravity_beam_boolean()
	set_abductee_speed()
	move_and_slide_with_snap(abductee_speed, slide, UP, true)
			
	
func set_abductee_speed():
	if in_gravity_beam == true:
		abductee_speed.y = SPEED + 50
	else: 
		abductee_speed.y = -SPEED 
		
func set_gravity_beam_boolean():
	if $RayCast2D.is_colliding():
		in_gravity_beam = true
	else:
		in_gravity_beam = false
	
func _on_AbductionArea_area_entered(area: Area2D) -> void:
	get_tree().call_group("GUI", "increase_score")
	queue_free()
