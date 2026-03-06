extends Control

var item_quantity : int
var item_image : String

var parent : Control
var poz : Vector2i

var ok_to_select : bool = true

func _ready():
	Update()

func Update(i_quantity:int = 0,i_image:String = '')->void:
	if i_image=='' or i_quantity==0:
		$TextureRect/quantity_display.text=''
		item_image=''
		$TextureRect.texture=null
		return
	$TextureRect/quantity_display.text=str(i_quantity)
	item_quantity=i_quantity
	$TextureRect.texture=load(i_image)
	item_image=i_image


func _on_gui_input(event):
	if ok_to_select and event is InputEventMouseButton:
		ok_to_select=false
		if event.button_index==1:
			InventoryHandler.add_for_swap(poz,parent)
		elif event.button_index==2:
			InventoryHandler.Interact(poz,parent)
		await get_tree().create_timer(0.3).timeout
		ok_to_select=true
