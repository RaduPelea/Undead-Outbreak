extends Node


var inv_to_swap : Control = null
var poz_to_swap : Vector2i = Vector2i.ZERO
var swaping : bool = false

var ghost_sprite : TextureRect


var placed_ghost : bool = false

func _ready():
	pass
	
	

func appear_ghost()->void:
	ghost_sprite = TextureRect.new()
	ghost_sprite.size=Vector2(16,16)
	ghost_sprite.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
	ghost_sprite.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	ghost_sprite.mouse_filter=Control.MOUSE_FILTER_IGNORE
	ghost_sprite.modulate=Color(1,1,1,1)

	#add_child(ghost_sprite)
func _process(delta):
	if Global.player_inv==null:
		return
	if Global.player_inv.open==false:
			ghost_sprite.modulate=Color(1,1,1,0)
	else:
			ghost_sprite.position=get_viewport().get_mouse_position()

func add_for_swap(poz :Vector2i,inv : Control)->void:
	
	if inv_to_swap==null:
		inv_to_swap=inv
		poz_to_swap=poz
		if ! placed_ghost:
			Global.hud.add_child(ghost_sprite)
			placed_ghost=true
		
		
		if inv_to_swap.data[poz_to_swap].item!=null:
			ghost_sprite.texture=load(inv_to_swap.data[poz_to_swap].item.image)
			ghost_sprite.modulate=Color(1,1,1,0.5)
			inv_to_swap.data[poz_to_swap].visual.Update(0,'')
		swaping=true
		return
	
	
	var aux : Dictionary
	
	aux.item = inv_to_swap.data[poz_to_swap].item
	aux.quantity = inv_to_swap.data[poz_to_swap].quantity
	
	
	inv_to_swap.data[poz_to_swap].item=inv.data[poz].item
	inv_to_swap.data[poz_to_swap].quantity=inv.data[poz].quantity
	
	inv.data[poz].item=aux.item
	inv.data[poz].quantity=aux.quantity
	
	#inv_to_swap.data[poz_to_swap] =inv.data[poz]
	#inv.data[poz]=aux
	
	ghost_sprite.modulate=Color(1,1,1,0)
	inv_to_swap.Update()
	inv.Update()
	
	
	
	inv_to_swap=null
	poz_to_swap=Vector2i.ZERO
	swaping=false


func Interact(poz : Vector2i,inv : Control)->void:
	var item : base_item = inv.data[poz].item
	
	if item==null:
		return
	
	if item.utility=='weapon':
		Global.bullet_component.change_weapon(Data.weapons[item.type])
		#Global.player_inv.delete_type(item.type,1)
		return
	if item.utility=='health_recovery':
		Global.player_health.regenerate(item.add_value)
		inv.data[poz].quantity-=1
		if inv.data[poz].quantity==0:
			inv.data[poz].item=null
		inv.Update()
		return
	if item.utility=='hunger_recovery':
		Global.player_hunger.regenerate_hunger(item.add_value)
		inv.data[poz].quantity-=1
		if inv.data[poz].quantity==0:
			inv.data[poz].item=null
		inv.Update()
		return
	if item.utility=='thirst_recovery':
		Global.player_hunger.regenerate_thirst(item.add_value)
		inv.data[poz].quantity-=1
		if inv.data[poz].quantity==0:
			inv.data[poz].item=null
		inv.Update()
		return

