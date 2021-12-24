extends Resource
tool
class_name civ_TileData

export(String) var tile_name = ""
export(gl.TileType) var tile_type setget set_tile_type
export(Array,Resource) var space_data_array = [] setget set_space_data_array

func try_connect_space_data():
	for space_data in space_data_array:
		if space_data.is_connected("changed",self,"emit_changed"):
			continue
		space_data.connect("changed",self,"emit_changed")

func set_tile_type(new_tile_type):
	tile_type = new_tile_type
	try_connect_space_data()
	emit_changed()

func set_space_data_array(new_space_data_array):
	space_data_array = new_space_data_array
	try_connect_space_data()
	emit_changed()
