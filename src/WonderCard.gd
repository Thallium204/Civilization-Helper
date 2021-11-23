tool
extends Control

var auto_detect = false setget set_auto_detect

var wonder_name = "Default" setget set_wonder_name
var era_type = gl.ERA_ANCIENT setget set_era_type
var focus_type = gl.FOCUS_CULTURE setget set_focus_type
var description = "lorem ipsum" setget set_description
var base_cost = 7 setget set_base_cost
var cost_mod = 0 setget set_cost_mod
var additional_resource = gl.RESOURCE_MARBLE setget set_additional_resource

onready var wonder_name_label = $NameBG/Label
onready var wonder_image = $ImageBorder/WonderImage
onready var focus_bg = $ImageBorder/BG
onready var era_label = $EraBG/Label
onready var focus_texture = $FocusDecorator/FocusImage
onready var description_label = $Decription/Label
onready var wonder_cost = $CostDecorator/Label
onready var innate_resource_image = $InnateResource/Image
onready var additional_resource_image = $AdditionalResource/Image

func set_auto_detect(_new_auto_detect=false):
	if data.WONDER.has(wonder_name):
		var dat = data.WONDER[wonder_name]
		set_wonder_name(wonder_name)
		update_wonder_image_UI(dat.image_name)
		set_era_type(dat.era_type)
		set_focus_type(dat.focus_type)
		set_description(dat.description)
		set_base_cost(dat.cost)
		set_additional_resource(dat.additional_resource)

func set_wonder_name(new_wonder_name):
	wonder_name = new_wonder_name
	update_wonder_name_UI()

func update_wonder_name_UI():
	if wonder_name_label:
		wonder_name_label.text = wonder_name

func update_wonder_image_UI(image_pathname):
	if wonder_image:
		wonder_image.texture = load("res://assets/wonder images/"+image_pathname+".png")

func set_era_type(new_era_type):
	era_type = new_era_type
	update_era_UI()

func update_era_UI():
	if era_label:
		era_label.text = gl.ERA_NAMES_LIST[era_type]

func set_focus_type(new_focus_type):
	focus_type = new_focus_type
	update_focus_UI()

func update_focus_UI():
	if focus_bg:
		focus_bg.self_modulate = gl.FOCUS_COLOR[focus_type]
	if focus_texture:
		focus_texture.texture = gl.get_focus_image(focus_type)
	update_innate_resource_UI()

func set_description(new_description):
	description = new_description
	update_description_UI()

func update_description_UI():
	if description_label:
		description_label.text = description

func set_base_cost(new_base_cost):
	base_cost = new_base_cost
	update_cost_UI()

func set_cost_mod(new_cost_mod):
	cost_mod = new_cost_mod
	update_cost_UI()

func update_cost_UI():
	if wonder_cost:
		wonder_cost.text = str(base_cost + cost_mod)
		if cost_mod < 0:
			wonder_cost.set("custom_colors/font_color",Color.aquamarine)
			$Highlight.material.set_shader_param("is_selected",true)
		elif cost_mod > 0:
			wonder_cost.set("custom_colors/font_color",Color.salmon)
			$Highlight.material.set_shader_param("is_selected",true)
		else:
			wonder_cost.set("custom_colors/font_color",Color.white)
			$Highlight.material.set_shader_param("is_selected",false)

func set_additional_resource(new_additional_resource):
	additional_resource = new_additional_resource
	update_additional_resource_UI()

func update_additional_resource_UI():
	if additional_resource_image:
		additional_resource_image.texture = gl.get_resource_image(additional_resource)

func update_innate_resource_UI():
	if innate_resource_image:
		innate_resource_image.texture = gl.get_resource_image_by_focus_type(focus_type)

func _ready():
	set_auto_detect()

func _get_property_list():
	
	return [
		{
			name = "Wonder Card",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "wonder_name",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
				{
			name = "auto_detect",
			type = TYPE_BOOL,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "era_type",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.ERA_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "focus_type",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.FOCUS_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "description",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_MULTILINE_TEXT,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "base_cost",
			type = TYPE_INT,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "cost_mod",
			type = TYPE_INT,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "additional_resource",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.RESOURCE_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		]



