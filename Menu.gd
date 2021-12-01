extends Control

const TWEEN_TRANS = Tween.TRANS_CUBIC
const TWEEN_SPEED = 0.8

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		pass
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		# For android
		pass

