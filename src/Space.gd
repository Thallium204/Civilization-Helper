extends Node2D

var terrain_type = gl.TERRAIN_TYPE_FOREST setget set_terrain_type

var is_hovering = false setget set_is_hovering
var is_selectable = true setget set_is_selectable
var is_selected = false setget set_is_selected

onready var CMPVisual:civ_CMPVisual = $CMPVisual
onready var CMPInterface:civ_CMPInterface = $CMPInterface

func set_is_hovering(new_is_hovering):
	is_hovering = new_is_hovering
	if CMPVisual:
		CMPVisual.update_hovering(is_hovering)

func set_terrain_type(new_terrain_type):
	terrain_type = new_terrain_type
	if CMPVisual:
		CMPVisual.update_terrain(terrain_type)

func set_is_selectable(new_is_selectable):
	is_selectable = new_is_selectable
	if CMPVisual:
		CMPVisual.update_selectable(is_selectable)

func set_is_selected(new_is_selected):
	is_selected = new_is_selected
	if CMPVisual:
		CMPVisual.update_selected(is_selected)

func _ready():
	connect_components()
	set_terrain_type(terrain_type)
	set_is_selectable(is_selectable)
	set_is_selected(is_selected)

func interpret_event(event:InputEventMouseButton):
	
	if is_selectable and event.pressed and event.button_index == BUTTON_LEFT:
		self.is_selected = not is_selected

func connect_components():
	var _err
	_err = CMPInterface.connect("hovering_changed",self,"set_is_hovering")
	_err = CMPInterface.connect("button_input",self,"interpret_event")





