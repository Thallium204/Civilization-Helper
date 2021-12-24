class_name civ_Space
tool
extends Node2D

export(Resource) var space_data = space_data as civ_SpaceData setget set_space_data

export var move_mode = false setget set_move_mode

export var is_hovering = false setget set_is_hovering
export var is_selectable = false setget set_is_selectable
export var is_selected = false setget set_is_selected

export(Array) var adjacent_spaces = []

export var snap = false setget snap_to_grid

onready var CMPVisual:civ_CMPVisual = $CMPVisual
onready var CMPInterface:civ_CMPInterface = $CMPInterface

func set_space_data(new_space_data):
	space_data = new_space_data
	update_all_UI()

func set_move_mode(new_move_mode):
	move_mode = new_move_mode
	if CMPVisual:
		CMPVisual.update_move_mode(move_mode)
	if not move_mode:
		snap_to_grid()

func set_is_hovering(new_is_hovering):
	is_hovering = new_is_hovering
	if CMPVisual:
		CMPVisual.update_hovering(is_hovering)

func set_is_selectable(new_is_selectable):
	is_selectable = new_is_selectable
	if CMPVisual:
		CMPVisual.update_selectable(is_selectable)

func set_is_selected(new_is_selected):
	is_selected = new_is_selected
	if CMPVisual:
		CMPVisual.update_selected(is_selected)

func snap_to_grid(_err=false):
	position = gl.snap_to_hex_grid(position)




func move_self(relative):
	position += relative

func _ready():
	add_to_group("space")
	connect_components()
	update_all_UI()

func update_all_UI():
	if CMPVisual:
		CMPVisual.update_terrain(space_data.terrain_data)
		CMPVisual.update_spawn(space_data.spawn_data)
		CMPVisual.update_construct(space_data.construct_data)
	set_is_selectable(is_selectable)
	set_is_selected(is_selected)

func interpret_event(event:InputEventMouseButton):
	
	if is_selectable and event.pressed and event.button_index == BUTTON_LEFT:
		self.is_selected = not is_selected

func connect_components():
	var _err
	_err = space_data.connect("changed",self,"update_all_UI")
	_err = CMPInterface.connect("hovering_changed",self,"set_is_hovering")
	_err = CMPInterface.connect("button_input",self,"interpret_event")

func populate_space():
	if space_data.spawn_data is civ_BarbarianData:
		pass
	elif space_data.spawn_data is civ_CityStateData:
		space_data.construct_data = space_data.spawn_data
	elif space_data.spawn_data is civ_ResourceData:
		space_data.construct_data = space_data.spawn_data
	elif space_data.terrain_data is civ_TerrainWonderData:
		space_data.construct_data = space_data.terrain_data.resource_data
	elif space_data.spawn_data is civ_CityData:
		space_data.construct_data = space_data.spawn_data
	if space_data.spawn_data:
		print("spawned ",space_data.spawn_data.name)



