tool
extends Node2D

export(Resource) var tile_data = tile_data as civ_TileData setget set_tile_data

func set_tile_data(new_tile_data):
	tile_data = new_tile_data
	try_connect_tile_data()
	update_spaces()

func _ready():
	try_connect_tile_data()
	update_spaces()

func try_connect_tile_data():
	if tile_data.is_connected("changed",self,"update_spaces"):
		return
	tile_data.connect("changed",self,"update_spaces")

func update_spaces():
	var space_array = get_children()
	if space_array.empty():
		return
	
	var position_array = gl.get_tile_positions(tile_data.tile_type)
	for id in tile_data.space_data_array.size():
		var space:civ_Space = space_array[id]
		var space_data:civ_SpaceData = tile_data.space_data_array[id]
		space.space_data = space_data
		space.position = position_array[id]
