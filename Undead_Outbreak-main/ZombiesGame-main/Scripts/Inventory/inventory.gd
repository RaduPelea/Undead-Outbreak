extends Control

@export var Size : Vector2i

var data : Dictionary # keep the quantity and type of an item

var item_slot : PackedScene = preload("res://Scenes/Inventory/item_slot.tscn")

var item_slot_size : Vector2i = Vector2i(16,16)

var open : bool = false

var it : base_item
func _ready():
	CreateGui()
	
	
	#add_item(Data.food,5)
	#add_item(Data.medium_bullets,200)
	#add_item(Data.sniper_bullets,200)
	#add_item(Data.shotgun_bullets,100)
	#add_item(Data.pistol_item,1)
func _process(delta):
	if Input.is_action_just_pressed("escape"):
		hide_inventory()
	#if Input.is_action_just_pressed("Primary"):
	#	add_item(it,3)
	#if Input.is_action_just_pressed("ui_cancel"):
	#	delete_item(it,4)
	pass

func CreateGui()->void:
	data.clear()
	for i in $grid.get_children():
		i.queue_free()
	$grid.set_deferred('size',Vector2(Size.y * item_slot_size.y + Size.y-1,Size.x * item_slot_size.x + Size.x-1))
	$grid.columns=Size.y
	$grid.add_theme_constant_override("h_separation",1)
	$grid.add_theme_constant_override("v_separation",1)
	var nr:int = 1
	for i in Size.x:
		for j in Size.y:
			var x : Control = item_slot.instantiate()
			x.name=str(nr)
			#x.get_node("TexutreRect").texture
			$grid.add_child(x)
			
			x.parent = self
			x.poz = Vector2i(i,j)
			
			x.size_flags_horizontal=1 | 2
			x.size_flags_vertical  =1 | 2
			if data.has(Vector2i(i,j))==false:
				data[Vector2i(i,j)]={'item' : null,'visual' : null,'quantity' : 0}
				data[Vector2i(i,j)].visual=x
			else:
				data[Vector2i(i,j)].visual=x
				x.Update(data[Vector2i(i,j)].quantity,data[Vector2i(i,j)].item.image)
			nr+=1

func show_inventory()->void:
	open=true
	visible=true
	Update()

func Update()->void:
	for i in data.values():
		if i.item==null:
			i.visual.Update()
		else:
			i.visual.Update(i.quantity,i.item.image)

func get_item_of_type(type : String)->base_item:
	for i in data.values():
		if i.item!=null and i.item.type==type:
			return i.item
	return null
func add_item(item : base_item,quantity : int)->int:
	for i in data.values():
		if quantity==0:
			return 0
		if i.item==null:
			i.item=item
			if quantity>=item.max_quantity:
				i.quantity=item.max_quantity
				quantity-=item.max_quantity
			else:
				i.quantity=quantity
				quantity=0
		elif i.item==item:
			if i.quantity==item.max_quantity:
				continue
			var dif : int = item.max_quantity-i.quantity
			if quantity>=dif:
				i.quantity=item.max_quantity
				quantity-=dif
			else:
				i.quantity+=quantity
				quantity=0
		
		if i.item==null:
			i.visual.Update(i.quantity,'')
		else:
			i.visual.Update(i.quantity,i.item.image)
	return quantity

func get_amount_of_item(item : base_item)->int:
	var nr : int = 0
	for i in data.values():
		if i.item==null:
			continue
		if i.item.type==item.type:
			nr += i.quantity
	return nr

func get_amount_of_type(type : String)->int:
	var nr : int = 0
	for i in data.values():
		if i.item==null:
			continue
		if i.item.type==type:
			nr += i.quantity
	return nr



func sorting_amounts()->void:
	var aux : Dictionary
	for i in data.values():
		if i.item!=null:
			if aux.has(i.item.type):
				aux[i.item.type].quantity+=i.quantity
			else:
				aux[i.item.type] = {'item' : i.item,'quantity' : i.quantity}
				
	
	#print(aux)
	
	CreateGui()
	for i in aux.values():
		add_item(i.item,i.quantity)



func delete_item(item : base_item,quantity : int)->bool:
	if get_amount_of_item(item)<quantity:
		return false
	for i in data.values():
		if quantity==0:
			return true
		if i.item==null:
			i.visual.Update(i.quantity,'')
			continue
		if i.item.type==item.type:
			
			if quantity > i.quantity:
				quantity-=i.quantity
				i.quantity=0
				i.item=null
			else:
				i.quantity-=quantity
				quantity=0
			
		if i.item==null:
			i.visual.Update(i.quantity,'')
		else:
			i.visual.Update(i.quantity,i.item.image)
	
	if quantity==0:
		return true
	
	return false

func delete_type(type : String,quantity : int)->bool:
	if get_amount_of_type(type)<quantity:
		return false
	for i in data.values():
		if quantity==0:
			return true
		if i.item==null:
			i.visual.Update(i.quantity,'')
			continue
		if i.item.type==type:
			
			if quantity > i.quantity:
				quantity-=i.quantity
				i.quantity=0
				i.item=null
			else:
				i.quantity-=quantity
				quantity=0
			
		if i.item==null:
			i.visual.Update(i.quantity,'')
		else:
			i.visual.Update(i.quantity,i.item.image)
	
	if quantity==0:
		return true
	
	return false




func hide_inventory()->void:
	open=false
	visible=false
	InventoryHandler.swaping=false
	InventoryHandler.inv_to_swap=null
	InventoryHandler.poz_to_swap=Vector2i.ZERO

