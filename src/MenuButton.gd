class_name civ_MenuButton
extends Button

const TWEEN_SPEED = 0.4

var _err

export(NodePath) var control_path
export(NodePath) var camera_path
export(NodePath) var tween_path

onready var control:Control
onready var camera:Camera2D
onready var tween:Tween

func _ready():
	_err = connect("pressed",self,"button_pressed")
	if control_path:
		control = get_node(control_path)
	if camera_path:
		camera = get_node(camera_path)
	if tween_path:
		tween = get_node(tween_path)

func button_pressed():
	make_button_pressed()
	move_camera()

func make_button_pressed():
	for btn in group.get_buttons():
		var button = btn
		if button == self:
			button.pressed = true
			if button.control:
				_err = tween.interpolate_property(
					button.control,"modulate",
					null,Color.white,
					TWEEN_SPEED,Tween.TRANS_LINEAR,Tween.EASE_IN
				)
				button.control.visible = true
				_err = tween.interpolate_callback(button.control,TWEEN_SPEED,"set_visible",true)
		else:
			button.pressed = false
			if button.control:
				_err = tween.interpolate_property(
					button.control,"modulate",
					null,Color(1,1,1,0),
					TWEEN_SPEED,Tween.TRANS_LINEAR,Tween.EASE_IN
				)
				_err = tween.interpolate_callback(button.control,TWEEN_SPEED,"set_visible",false)
	_err = tween.start()

func move_camera():
	_err = tween.interpolate_property(
		camera,"position",
		null,Vector2(0,control.rect_position.y) + Vector2(3168,1440)/2.0,
		TWEEN_SPEED,Tween.TRANS_LINEAR,Tween.EASE_IN
	)
	_err = tween.start()
