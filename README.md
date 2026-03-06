Undead-Outbreak is a survival 2D shooter. You are spawned in a city filled with zombies and your purpose is to get the antidote from the four corners of the map.
You can collect weapons, ammo and different collectables like food, water and medicine from different types of crates spawned within buildings. 
As you get closer to the edge of the map, zombies have a higher rate of appearance, so you need to gather enough resources before you try to collect the medicine.

How I built it : 
1. The map is procedurally generated, so you will never play the same game twice.
2. Zombies simulate vision using raycasting to detect the player and navigate around obstacles.
3. Saving system : It tracks the city seed, specific coordinates of every active zombie, player statistics, and inventory contents.
4. Graphics : All the graphics are made by myself in Aseprite.
5. Inventory system : Each inventory slot uses maps to store information about what each slot contains.
                      All the items in the game are spawned in 3 different types of crates that are randomly generated withing various building types.
                      Each type of weapon/consumable has a lower/higher spawn rate within the crates based by how useful they are.

How to install:

I added an executable (UndeadOutbreak.exe). You can directly download it and run it. Unfortunately it only runs on windows.
For a better view of the project :
1. git clone https://github.com/RaduPelea/Undead-Outbreak .
2. Install Godot 4.4 and open the downloaded files in the game engine.

Credits: This project was built by Mitri Robert-Cristian and Pelea Radu-Stefan.
