/home/vladimir/Programms/cuda/bin/nvcc Game.cpp Menu_scene.cpp Scene_manager.cpp main.cpp Scene.cpp Game_scene.cpp Particle.cpp Pause_scene.cpp Vector.cpp SystemOfParticles.cu -c --gpu-architecture=sm_61
/home/vladimir/Programms/cuda/bin/nvcc Game.o Menu_scene.o Scene_manager.o main.o Scene.o Game_scene.o Pause_scene.o Particle.o Vector.o SystemOfParticles.o -o a.out --gpu-architecture=sm_61 -lsfml-graphics -lsfml-window -lsfml-system
./a.out
