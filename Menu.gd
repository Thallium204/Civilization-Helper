extends Control

const TWEEN_TRANS = Tween.TRANS_CUBIC
const TWEEN_SPEED = 0.8

onready var center = rect_size/2.0
onready var top_left = center + Vector2(-rect_size.x,-rect_size.y)
onready var top_right = center + Vector2(rect_size.x,-rect_size.y)
onready var bottom_left = center + Vector2(-rect_size.x,rect_size.y)
onready var bottom_right = center + Vector2(rect_size.x,rect_size.y)
onready var bottom = center + Vector2(0,rect_size.y)

func _on_ButtonSimulator_pressed():
	$Tween.interpolate_property($Camera2D,"position",null,top_left,TWEEN_SPEED,TWEEN_TRANS,Tween.EASE_OUT)
	$Tween.start()

func _on_ButtonInspector_pressed():
	$Tween.interpolate_property($Camera2D,"position",null,bottom_left,TWEEN_SPEED,TWEEN_TRANS,Tween.EASE_OUT)
	$Tween.start()

func _on_FocusCardInspector_pressed():
	$Tween.interpolate_property($Camera2D,"position",null,bottom_right,TWEEN_SPEED,TWEEN_TRANS,Tween.EASE_OUT)
	$Tween.start()

func _on_ButtonSelector_pressed():
	$Tween.interpolate_property($Camera2D,"position",null,bottom,TWEEN_SPEED,TWEEN_TRANS,Tween.EASE_OUT)
	$Tween.start()



func _on_Button_pressed():
	$Tween.interpolate_property($Camera2D,"position",null,center,TWEEN_SPEED,TWEEN_TRANS,Tween.EASE_OUT)
	$Tween.start()

