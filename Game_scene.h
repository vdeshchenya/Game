#pragma once
#ifndef GMAE_GAME_SCENE_H
#define GMAE_GAME_SCENE_H
#include "Scene.h"
#include <set>
#include "SystemOfParticles.h"

class Game_scene : public Scene {
 public:
  Game_scene(const int &width_, const int &height, RenderWindow &window);

  void draw(RenderWindow &window, ll &time) override;
  void keyRelease(Keyboard::Key &code);
  void mouseleft(const double& x, const double& y);

 private:
  SystemOfParticles System;
  double fieldw, fieldh;
  double R = 3;

  void DrawSystem(RenderWindow &window);
};

#endif //GMAE_GAME_SCENE_H
