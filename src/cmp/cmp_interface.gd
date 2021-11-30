class_name civ_CMPInterface
extends Node2D

signal hovering_changed(state)
signal button_input(event)

var is_pickable = true setget set_is_pickable
var is_listening

onready var body:StaticBody2D = $body

func set_is_pickable(new_is_pickable):
	is_pickable = new_is_pickable
	if body:
		body.input_pickable = is_pickable


func _on_body_mouse_entered():
	emit_signal("hovering_changed",true)

func _on_body_mouse_exited():
	emit_signal("hovering_changed",false)


func _on_body_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton:
		
		emit_signal("button_input",event)
