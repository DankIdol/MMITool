tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("MMITool", "Spatial", preload("res://addons/MMITool/Node.gd"), preload("res://addons/MMITool/icon.png"))


func _exit_tree():
	remove_custom_type("MMITool")
