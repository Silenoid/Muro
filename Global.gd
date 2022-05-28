extends Node

onready var alertDialog : AcceptDialog = get_node("/root/MainNode/MainControl/AlertDialog")

func alert_user(message: String):
	print("Alerting user: ", message)
	alertDialog.dialog_text = message
	alertDialog.popup_centered()
	
