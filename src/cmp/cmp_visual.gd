class_name civ_CMPVisual
extends Node2D

onready var SpriteTerrain = $SpriteTerrain

func update_visual(terrain_id):
	SpriteTerrain.texture = assets.get_terrain_image(terrain_id)
