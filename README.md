###   Date: Wed-24-July-2024

# RayMarching_ModernGL

First Introduction to Ray Marching

##	Language

Python

##	How to Setup and Run --- Steps

1.	Create a virtual environment in the `RayMarching_ModernGL` folder/directory by running `pip -m venv <name_of_virtual_environment>` in the command line in the same directory. The environment name should be ideally '.venv'.
	-	Then in the command line, activate the environment: `.venv\Scripts\activate.bat` (for Windows) or `source .venv\bin\activate` (for Linux) `
	-	Then `pip install -r requirements.txt` pr `pip3 install -r requirements.txt` (for Linux).

2.	Then explore "project1" and "project2" in the "source" folder.

3.	open each 'form' folder as they show different timelines of the code and the scripts explain what each does.
	-	Before running, if in an IDE, and run the main.py either in a chosen IDE (recommend VSCode) ensure to select the virtual environment for the Python interpreter or in the command line, after activating the virtual environment, run `python main.py` in the `form` folder you choose.


##   Briefing
These projects demonstrates Procedural generation of 3d artifacts using Ray Marching technique.
This is done with Moderngl.
It does not use polygonaml meshes; the lighting, shadows, and objects and the interactions between them are generated in real time using some ray casting techinques.
Furthermore, the Sphere Tracing (Ray Marching) algorithm is used.

The unqiqueness of RayMarching is that one creates 3D objects and scenes with out the use of polygons or loading textures.

The video that demonstrates the project goes through the process of creating the procedural objects, and the result is the animated scene presented.

The projects are two in total; the second is a continuation of the former.



##   References

Project 1:
Coder Space (2022), "Procedural 3D Engine. Ray MArching OpenGL Tutorilal", Youtube.

Project 2:
Coder Space (2022), "Advanced Procedural 3D Graphics. Ray Marching Tutorial", Youtube.

##  Project1 Done: Thurs-25-July-2024
##  Project2 Done: Fri-26-July-2024