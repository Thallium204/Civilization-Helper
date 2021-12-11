tool
extends Control

export(Resource) var world_wonder_data = world_wonder_data as civ_WorldWonderData setget set_world_wonder_data
export(int) var cost_mod = 0 setget set_cost_mod

export(NodePath) onready var wonder_name_label = get_node(wonder_name_label) as Label
export(NodePath) onready var wonder_image = get_node(wonder_image) as TextureRect
export(NodePath) onready var focus_bg = get_node(focus_bg) as NinePatchRect
export(NodePath) onready var era_label = get_node(era_label) as Label
export(NodePath) onready var focus_texture = get_node(focus_texture) as TextureRect
export(NodePath) onready var ability_text_label = get_node(ability_text_label) as Label
export(NodePath) onready var wonder_cost = get_node(wonder_cost) as Label
export(NodePath) onready var primary_resource_image = get_node(primary_resource_image) as TextureRect
export(NodePath) onready var secondary_resource_image = get_node(secondary_resource_image) as TextureRect


func set_world_wonder_data(new_world_wonder_data):
	world_wonder_data = new_world_wonder_data
	update_all_UI()

func set_cost_mod(new_cost_mod):
	cost_mod = new_cost_mod
	update_cost_UI()

### methods

func _ready():
	update_all_UI()

func update_wonder_name_UI():
	if wonder_name_label is Node:
		wonder_name_label.text = world_wonder_data.name

func update_wonder_image_UI():
	if wonder_image is Node:
		wonder_image.texture = world_wonder_data.image

func update_era_UI():
	if era_label is Node:
		era_label.text = gl.ERA_NAMES_LIST[world_wonder_data.era_type]

func update_focus_UI():
	if focus_bg is Node:
		focus_bg.self_modulate = gl.FOCUS_COLOR[world_wonder_data.focus_type]
	if focus_texture is Node:
		focus_texture.texture = assets.get_focus_image(world_wonder_data.focus_type)

func update_ability_text_UI():
	if ability_text_label is Node:
		ability_text_label.text = world_wonder_data.ability_text

func update_cost_UI():
	if wonder_cost is Node:
		wonder_cost.text = str(world_wonder_data.cost_base + cost_mod)
		if cost_mod < 0:
			wonder_cost.set("custom_colors/font_color",Color.aquamarine)
			$Highlight.material.set_shader_param("is_selected",true)
		elif cost_mod > 0:
			wonder_cost.set("custom_colors/font_color",Color.salmon)
			$Highlight.material.set_shader_param("is_selected",true)
		else:
			wonder_cost.set("custom_colors/font_color",Color.white)
			$Highlight.material.set_shader_param("is_selected",false)


func update_primary_resource_UI():
	if primary_resource_image is Node:
		primary_resource_image.texture = world_wonder_data.primary_resource_data.image

func update_secondary_resource_UI():
	if secondary_resource_image is Node:
		secondary_resource_image.texture = world_wonder_data.secondary_resource_data.image

func update_all_UI():
	update_wonder_name_UI()
	update_wonder_image_UI()
	update_era_UI()
	update_focus_UI()
	update_ability_text_UI()
	update_cost_UI()
	update_primary_resource_UI()
	update_secondary_resource_UI()

#func _get_property_list():
#
#	return [
#		{
#			name = "Wonder Card",
#			type = TYPE_NIL,
#			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "wonder_name",
#			type = TYPE_STRING,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#				{
#			name = "auto_detect",
#			type = TYPE_BOOL,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "era_type",
#			type = TYPE_INT,
#			hint = PROPERTY_HINT_ENUM,
#			hint_string = gl.ERA_NAMES,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "focus_type",
#			type = TYPE_INT,
#			hint = PROPERTY_HINT_ENUM,
#			hint_string = gl.FOCUS_NAMES,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "description",
#			type = TYPE_STRING,
#			hint = PROPERTY_HINT_MULTILINE_TEXT,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "base_cost",
#			type = TYPE_INT,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "cost_mod",
#			type = TYPE_INT,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#		{
#			name = "additional_resource",
#			type = TYPE_INT,
#			hint = PROPERTY_HINT_ENUM,
#			hint_string = gl.RESOURCE_NAMES,
#			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
#		},
#	]



