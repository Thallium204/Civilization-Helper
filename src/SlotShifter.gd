class_name civ_SlotShifter
tool
extends Control

enum {
	SHIFTER_TYPE_GOVERMENT,
	SHIFTER_TYPE_TAJ,
	SHIFTER_TYPE_MACHU,
	SHIFTER_TYPE_GEORGIA,
}

var active = false setget set_active

onready var image = $HBox/TypeDecorator/Image
onready var arrow1 = $HBox/Arrow
onready var arrow2 = $HBox/Arrow2

func set_active(new_active):
	active = new_active
	visible = active

func _ready():
	set_active(active)

func set_texture(texture):
	if image:
		image.texture = texture

func set_arrows(arrow_number):
	arrow2.visible = (arrow_number == 2)
