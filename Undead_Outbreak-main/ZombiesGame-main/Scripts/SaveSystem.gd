extends Node

const save_file : String = 'user://savefile.save'

var game_data : Dictionary

var zmb = preload("res://Scenes/zombie.tscn")

func _save_game_dictionary()->void:
	game_data['health'] = Data.health
	game_data['thirst'] = Data.thirst
	game_data['hunger'] = Data.hunger
	game_data['stamina'] = Data.stamina
	game_data['player_pos'] = Global.player.global_position
	game_data['seed'] = Global.seed
	game_data['zombies'] = []
	game_data['goals'] = Global.goals
	for i in Data.zombies.keys():
		if i==null:
			continue
		game_data['zombies'].push_back(i.position)
	game_data['inv'] = []
	for i in Global.player_inv.data.keys():
		if  Global.player_inv.data[i].item!=null:
			game_data['inv'].push_back({
				'item' : Global.player_inv.data[i].item.type,
			'nr' : Global.player_inv.data[i].quantity})
	game_data['score']=Data.score
	
	
	
func _load_game_dictionary()->void:
	Global.player.set_player()
	Global.player.global_position=game_data['player_pos']
	Global.seed=game_data['seed']
	for i in game_data['zombies']:
		var z := zmb.instantiate()
		z.position = i
		Data.zombies[z]=1
	for i in game_data['inv']:
		Global.player_inv.add_item(Data.get(i.item),i.nr)
	
	Global.goals=game_data['goals']
	Data.score=game_data['score']
	
func save_data()->void:
	var f := FileAccess.open(save_file,FileAccess.WRITE)
	_save_game_dictionary()
	f.store_var(game_data)
	return
func load_data()->bool:
	var f := FileAccess.open(save_file,FileAccess.READ)
	game_data=f.get_var()
	if game_data.is_empty()==false:
		_load_game_dictionary()
		return true
	return false
	
	
func destroy_save_file()->void:
	var f := FileAccess.open(save_file,FileAccess.WRITE)
	f.store_var({})
	return
