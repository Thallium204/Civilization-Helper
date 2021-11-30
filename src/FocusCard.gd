tool
extends Control

var auto_detect = false setget set_auto_detect

var player_id = 0 setget set_player_id
var card_name = "Default" setget set_card_name
var focus_type = gl.FOCUS_CULTURE setget set_focus_type
var tech_level = gl.TECH_LEVEL_I setget set_tech_level
var description = "lorem ipsum" setget set_description

var has_government = true setget set_has_government

onready var card_name_label = $VBox/Card/NameBG/Label

onready var focus_texture = $VBox/Card/FocusDecorator/Type
onready var focus_label = $VBox/Card/FocusDecorator/LabelFocus
onready var tech_level_bg = $VBox/Card/FocusDecorator/Banner
onready var tech_level_label = $VBox/Card/FocusDecorator/LabelTech

onready var card_image = $VBox/Card/ImageBorder/Image
onready var card_image_bg = $VBox/Card/ImageBorder/BG

onready var description_label = $VBox/Card/Decription/Label

onready var slot_shift_stack = $VBox/SlotShift/HBox

func set_auto_detect(_new_auto_detect=false):
	if data.FOCUS.has(card_name):
		var dat = data.FOCUS[card_name]
		set_card_name(card_name)
		update_card_image_UI(dat.image_name)
		set_focus_type(dat.focus_type)
		set_tech_level(dat.tech_level)
		set_description(dat.description)
		set_has_government(has_government)

func set_player_id(new_player_id):
	player_id = new_player_id
	update_player_id_UI()

func update_player_id_UI():
	if tech_level_bg:
		tech_level_bg.modulate = gl.PLAYER_COLOR[player_id]
	if card_image_bg:
		card_image_bg.modulate = gl.PLAYER_COLOR[player_id]

func set_card_name(new_card_name):
	card_name = new_card_name
	update_card_name_UI()

func update_card_name_UI():
	if card_name_label:
		card_name_label.text = card_name

func update_card_image_UI(image_pathname):
	if card_image:
		card_image.texture = load("res://assets/focus images/"+image_pathname+".png")

func set_focus_type(new_focus_type):
	focus_type = new_focus_type
	update_focus_type_UI()

func update_focus_type_UI():
	if focus_texture:
		focus_texture.texture = assets.get_focus_image(focus_type)
	if focus_label:
		focus_label.text = gl.FOCUS_NAMES_PATHLIST[focus_type]

func set_tech_level(new_tech_level):
	tech_level = new_tech_level
	update_tech_level_UI()

func update_tech_level_UI():
	if tech_level_label:
		tech_level_label.text = gl.TECH_NAMES_LIST[tech_level]

func set_description(new_description):
	description = new_description
	update_description_UI()

func update_description_UI():
	if description_label:
		description_label.text = description

func set_has_government(new_has_government):
	has_government = new_has_government
	if slot_shift_stack:
		slot_shift_stack.update_stack(has_government,focus_type,player_id)

func _ready():
	set_auto_detect()



func _get_property_list():
	
	return [
		{
			name = "Focus Card",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "player_id",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.PLAYER_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "card_name",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
				{
			name = "auto_detect",
			type = TYPE_BOOL,
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
			name = "tech_level",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = gl.TECH_NAMES,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "description",
			type = TYPE_STRING,
			hint = PROPERTY_HINT_MULTILINE_TEXT,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			name = "has_government",
			type = TYPE_BOOL,
			usage = PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
	]
