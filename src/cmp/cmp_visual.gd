class_name civ_CMPVisual
extends Node2D

onready var SpriteTerrain = $SpriteTerrain

func update_terrain(terrain_id):
	SpriteTerrain.texture = assets.get_terrain_image(terrain_id)

func update_hovering(is_hovering):
	material.set_shader_param("is_hovering",is_hovering)

func update_selectable(is_selectable):
	material.set_shader_param("is_selectable",is_selectable)

func update_selected(is_selected):
	material.set_shader_param("is_selected",is_selected)
