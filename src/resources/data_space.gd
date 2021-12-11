class_name civ_SpaceData
tool
extends Resource

export(Resource) var terrain_data = terrain_data as civ_TerrainData setget set_terrain_data
export(Resource) var spawn_data setget set_spawn_data

func set_terrain_data(new_terrain_data):
	terrain_data = new_terrain_data
	emit_changed()

func set_spawn_data(new_spawn_data):
	spawn_data = new_spawn_data
	emit_changed()
