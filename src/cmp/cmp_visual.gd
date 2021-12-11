class_name civ_CMPVisual
tool
extends Node2D

onready var SpriteTerrain = $SpriteTerrain
onready var SpriteSpawn = $SpriteSpawn

func update_terrain(terrain_data:civ_TerrainData):
	SpriteTerrain.texture = terrain_data.image

func update_spawn(spawn_data):
	if spawn_data is civ_ResourceData:
		SpriteSpawn.texture = spawn_data.image
	elif spawn_data is civ_BarbarianData:
		SpriteSpawn.texture = spawn_data.spawn_image
	elif spawn_data is civ_CityStateData:
		SpriteSpawn.texture = spawn_data.image
	else:
		SpriteSpawn.texture = null

func update_hovering(is_hovering):
	material.set_shader_param("is_hovering",is_hovering)

func update_selectable(is_selectable):
	material.set_shader_param("is_selectable",is_selectable)

func update_selected(is_selected):
	material.set_shader_param("is_selected",is_selected)

func update_move_mode(move_mode):
	material.set_shader_param("move_mode",move_mode)
