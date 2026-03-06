Undead-Outbreak is an survival 2D shoother. You are spawned in a city filled with zombies and your purpose is to get the antidote from all the 4 corners of the map.
You can collet weapons, bullets and different collectables like food, water and medicine from different types of crates spawned in the buildings. 
As closer you get to the edge of the map, zombies have a hugher rate of appearance, so you need to get enough resources before you try to collect the medicine.

How I built it: 
1. The map is procedurally generated, so you will never play the same game twice.
2. Zombies simulate vision using raycasting to detect the player and navigate around obstacles.
3. Saving system : It tracks the city seed, specific coordinates of every active zombie, player statistics, and inventory contents.
4. Graphics : All the graphics are made by myself in Aseprite.
5. Inventory system : Each inventory slot uses maps to store information about what each slot contains.
                      All the items in the game are spawned in 3 different types of crates that are randomly generated withing all types off buildings.
                      Eache type of weapon/consumable has a lower/higher spawn rate within the crates based by how usefull they are.

How to install:

I added an executable (UndeadOutbreak.exe). You can directly download it and run it. Unfortunatly it only runs on windows.
For a better view of the project :
1. git clone https://github.com/RaduPelea/Undead-Outbreak .
2. Install Godot 4.4 and open the downloaded files in the game engine.
