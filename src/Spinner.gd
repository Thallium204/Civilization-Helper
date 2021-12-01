tool
extends TextureRect

const rot_at_1 = 88
const min_rots = 7

var rot_values = [
	rot_at_1+0,
	rot_at_1+60,
	rot_at_1+120,
	rot_at_1+180,
	rot_at_1+240,
	rot_at_1+300
]

export(float) var tex_size = 500.0 setget set_tex_size

func _ready():
	randomize()

func set_tex_size(new_tex_size):
	tex_size = new_tex_size
	update_size()

func update_size():
	margin_left = -tex_size/2.0
	margin_right = tex_size/2.0
	margin_top = -tex_size/2.0
	margin_bottom = tex_size/2.0
	rect_pivot_offset = Vector2.ONE * tex_size/2.0


func _on_ButtonSpin_pressed():
	rect_rotation = int(rect_rotation) % 360
	rot_values.shuffle()
	$Tween.interpolate_property(
		self,"rect_rotation",
		null,360*min_rots + rot_values[0],2.5,
		Tween.TRANS_CUBIC,Tween.EASE_OUT
	)
	$Tween.start()
