@tool
extends Button

class_name ItemButton

@export var item : Item :
	set(item_to_slot):
		item = item_to_slot
		icon = item.texture
	
var hand_equip : HandEquip

func _ready():
	if not Engine.is_editor_hint():
		if DisplayServer.is_touchscreen_available():
			connect("gui_input", _on_gui_input)
		else:
			connect("pressed", _on_pressed)

func _on_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_on_pressed()

func _on_pressed():
	if item is EquipableItem:
		if hand_equip:
			hand_equip.equipped_item = item
		else:
			print("HandEquip node is missing. Make sure it is added to the scene.")
	else:
		print("Item is not of type EquipableItem.")
