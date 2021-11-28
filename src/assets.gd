extends Node

const ASSET_ERROR_TERRAIN = preload("res://assets/terrain images/error.png")
const ASSET_ERROR_WONDER = preload("res://assets/wonder images/error.png")

func get_focus_image(focus_type):
	return load("res://assets/focus types/"+gl.FOCUS_NAMES_PATHLIST[focus_type]+".png")

func get_resource_image(resource_type):
	return load("res://assets/resources/"+gl.RESOURCE_NAMES_PATHLIST[resource_type]+".png")

func get_resource_image_by_focus_type(focus_type):
	return get_resource_image(gl.focus_to_resource_type(focus_type))

func get_wonder_image(wonder_name):
	if data.WONDER.has(wonder_name):
		var image_pathname = data.WONDER[wonder_name].image_name
		return load("res://assets/wonder images/"+image_pathname+".png")
	return ASSET_ERROR_WONDER

func get_terrain_image(terrain_id):
	if 0 <= terrain_id and terrain_id < gl.TERRAIN_NAMES_PATHLIST.size():
		var image_pathname = gl.TERRAIN_NAMES_PATHLIST[terrain_id]
		return load("res://assets/terrain images/"+image_pathname+".png")
	return ASSET_ERROR_TERRAIN
