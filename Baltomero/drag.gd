extends Area2D
var is_entered = false
var new_position = Vector2(0,0)
var is_dragging = false
var score = 0
const ROTATION_SPEED = 0.1
const POSITION_LERP = 0.2
const MAX_ROTATION = 275.0
var drag_offset = Vector2.ZERO
var last_x = 0.0
var current_rotation = 0.0
var target_rotation = 0.0
var entered_card = false
func _ready():
	new_position = position
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if is_entered == true:
			is_dragging = true
	if Input.is_action_just_released("click"):
		is_dragging = false
		if entered_card:
			position = %Area.position
	if is_dragging:
		var current_mouse_position = get_global_mouse_position()
		position = position.lerp(current_mouse_position + drag_offset, POSITION_LERP)
		var delta_x = current_mouse_position.x - last_x
		target_rotation = clamp((delta_x / 100.0) * MAX_ROTATION, -MAX_ROTATION, MAX_ROTATION)
		current_rotation = lerp(current_rotation, target_rotation, ROTATION_SPEED)
		rotation_degrees = current_rotation
		last_x = current_mouse_position.x
	else:
		current_rotation = lerp(current_rotation, 0.0, ROTATION_SPEED)
		rotation_degrees = current_rotation
func _on_mouse_entered():
	is_entered = true
	scale.x += 0.1
	scale.y += 0.1
func _on_mouse_exited():
	is_entered = false
	scale.x -= 0.1
	scale.y -= 0.1
func _on_card_entered(area):
	entered_card = true
	score +=2
func _on_card_exited(area):
	entered_card = false
	score-=2



