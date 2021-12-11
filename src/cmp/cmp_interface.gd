class_name civ_CMPInterface
tool
extends Node2D

signal hovering_changed(state)
signal button_input(event)

var is_pickable = false setget set_is_pickable
var is_listening

onready var body:StaticBody2D = $body

func set_is_pickable(new_is_pickable):
	is_pickable = new_is_pickable
	if body:
		body.input_pickable = is_pickable


#func get_adjacent_spaces(global_pos,space_exceptions=[get_parent()]):
#	var body_exceptions = []
#	for Space in space_exceptions:
#		body_exceptions.append(Space.CMPInterface.body)
#	var space_state = get_world_2d().direct_space_state
#	var adjacent_spaces = [null,null,null,null,null,null]
#	for pos in 6:
#		var direction = gl.DIRECTIONS[pos]
#		var dict = space_state.intersect_ray(global_pos,global_pos+direction*gl.HEX_X_VECTOR.x,body_exceptions)
#		if dict:
#			var Interface = dict.collider.get_parent()
#			adjacent_spaces[pos] = Interface.get_parent()
#	return adjacent_spaces
#
#
#func is_hex_taken(global_pos):
#	var space_state = get_world_2d().direct_space_state
#	for pos in 6:
#		var direction = gl.DIRECTIONS[pos]
#		var dict = space_state.intersect_ray(global_pos,global_pos+direction*gl.HEX_X_VECTOR.x/3.0,[body])
#		if dict:
#			return true
#	return false


func _on_body_mouse_entered():
	emit_signal("hovering_changed",true)

func _on_body_mouse_exited():
	emit_signal("hovering_changed",false)


func _on_body_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton:
		
		emit_signal("button_input",event)
