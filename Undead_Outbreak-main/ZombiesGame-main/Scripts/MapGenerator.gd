extends Node


@export var length_max : int 
@export var length_min : int







func GenMap(sz : int)->Dictionary:
	
	seed(Global.seed)
	var data : Dictionary
	
	var sp : Vector2i = Vector2i(-sz,-sz)
	
	for i in range(-sz,sz+1):
		data[Vector2i(-sz,i)]=true
		data[Vector2i(sz,i)]=true
		data[Vector2i(i,sz)]=true
		data[Vector2i(i,-sz)]=true
	
	var points : Array[Vector2i]
	while 1:
		data[sp]=true
		points.push_back(sp)
		var i : int = sp.x-1
		while i>-sz:
			data[Vector2i(sp.x,i)]=true
			data[Vector2i(i,sp.y)]=true
			i-=1
		
		var l : int = randi_range(length_min,length_max)
		if (sp + Vector2i(l,l)).x<sz-1:
			sp+=Vector2i(l,l)
		else:
			break
	
	for i in points:
		
		var x : Vector2i = i
		i.y+=1
		if randi()%2:
			while data.has(Vector2i(i.x,i.y))==false:
				data[Vector2i(i.x,i.y)]=true
				i.y+=1
		else:
			while i.y<sz:
				data[Vector2i(i.x,i.y)]=true
				i.y+=1
		i=x
		i.x+=1
		if randi()%2:
			while data.has(Vector2i(i.x,i.y))==false:
				data[Vector2i(i.x,i.y)]=true
				i.x+=1
		else:
			while i.x<sz:
				data[Vector2i(i.x,i.y)]=true
				i.x+=1
		
	#print(data)
	#for i in range(-sz,sz+1):
	#	var l : String
	#	for j in range(-sz,sz+1):
	#		if data.has(Vector2i(i,j)):
	#			l+=' 1'
	#		else:
	#			l+=' 0'
	#	print(l)
	
	
	return data



