class_name civ_CMPVisual
tool
extends Node2D

onready var SpriteTerrain = $SpriteTerrain
onready var SpriteSpawn = $SpriteSpawn
onready var SpriteConstruct = $SpriteConstruct
onready var ConstructLabel = $SpriteConstruct/Control/Label
onready var MaturityBar = $SpriteConstruct/Control/MaturityBar
onready var PlayerImage = $SpriteConstruct/Control/PlayerImage

func update_terrain(terrain_data:civ_TerrainData):
	SpriteTerrain.texture = terrain_data.image

func update_spawn(spawn_data):
	if spawn_data is civ_ResourceData:
		SpriteSpawn.texture = spawn_data.image
	elif spawn_data is civ_BarbarianData:
		SpriteSpawn.texture = spawn_data.spawn_image
	elif spawn_data is civ_CityStateData:
		SpriteSpawn.texture = spawn_data.image
	elif spawn_data is civ_CivilizationData:
		SpriteSpawn.texture = res.CAPITAL_SPAWN_IMAGE
	else:
		SpriteSpawn.texture = null

func update_construct(construct_data):
	MaturityBar.visible = false
	if construct_data is civ_ControlTokenData:
		SpriteConstruct.texture = construct_data.image
		ConstructLabel.text = construct_data.name
		PlayerImage.texture = construct_data.player_data.color_data.image
		PlayerImage.modulate = construct_data.player_data.color_data.color
	elif construct_data is civ_ResourceData:
		SpriteConstruct.texture = construct_data.image
		ConstructLabel.text = ""
		PlayerImage.texture = null
		PlayerImage.modulate = Color.white
	elif construct_data is civ_DistrictData:
		SpriteConstruct.texture = construct_data.image
		ConstructLabel.text = construct_data.name
		PlayerImage.texture = construct_data.player_data.color_data.color
		PlayerImage.modulate = construct_data.player_data.color_data.color
	elif construct_data is civ_CityData:
		SpriteConstruct.texture = construct_data.image
		ConstructLabel.text = construct_data.name
		PlayerImage.texture = construct_data.player_data.color_data.image
		PlayerImage.modulate = construct_data.player_data.color_data.color
		MaturityBar.visible = true
	elif construct_data is civ_CityStateData:
		SpriteConstruct.texture = res.CITY_STATE_IMAGE
		ConstructLabel.text = construct_data.name
		PlayerImage.texture = construct_data.image
		PlayerImage.modulate = Color.white
	else:
		SpriteConstruct.texture = null
		ConstructLabel.text = ""
		PlayerImage.texture = null
		PlayerImage.modulate = Color.white

func update_hovering(is_hovering):
	material.set_shader_param("is_hovering",is_hovering)

func update_selectable(is_selectable):
	material.set_shader_param("is_selectable",is_selectable)

func update_selected(is_selected):
	material.set_shader_param("is_selected",is_selected)

func update_move_mode(move_mode):
	material.set_shader_param("move_mode",move_mode)
