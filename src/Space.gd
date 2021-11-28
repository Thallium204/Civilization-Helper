extends Node2D

var terrain_type = gl.TERRAIN_TYPE_FOREST setget set_terrain_type

onready var CMPVisual = $CMPVisual

func set_terrain_type(new_terrain_type):
	terrain_type = new_terrain_type
	if CMPVisual:
		CMPVisual.update_visual(terrain_type)

func _ready():
	set_terrain_type(terrain_type)
