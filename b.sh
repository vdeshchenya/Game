/home/vladimir/Programms/intel/bin/icc -O3 -no-prec-div -xHost -qopenmp Game.cpp Menu_scene.cpp Scene_manager.cpp main.cpp Scene.cpp Game_scene.cpp Particle.cpp Pause_scene.cpp Vector.cpp SystemOfParticles.cpp -lsfml-graphics -lsfml-window -lsfml-system
source /home/vladimir/Programms/intel/bin/compilervars.sh intel64
./a.out
