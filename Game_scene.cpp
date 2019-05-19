#include "Game_scene.h"
#include <string>
#include <vector>
#include <iostream>

Game_scene::Game_scene(const int &width_, const int &height_, RenderWindow &window) : Scene(width_, height_),
                                                                                      fieldh(300),
                                                                                      fieldw(300) {
  System.Init(R);
}

void Game_scene::draw(RenderWindow &window, ll &time) {
  backgroundSprite.setTexture(backgroundTexture);
  window.draw(backgroundSprite);
  DrawSystem(window);
  System.Step(fieldw, fieldw);
}

void Game_scene::keyRelease(Keyboard::Key &code) {
  switch (code) {
    case Keyboard::E: {
      System.Add(200, 200);
      break;
    }
    case Keyboard::A: {
      for (int i = 0; i < 900; ++i)
        System.Add((1 + i % 30) * fieldw / 31, fieldh * (1 + i / 30) / 31);
      break;
    }
    default: break;
  }
}

void Game_scene::mouseleft(const double &x, const double &y) {
  System.Add(x, y);
}

void Game_scene::DrawSystem(RenderWindow &window) {
  for (int i = 0; i < System.GetNumbersOfParticles(); ++i) {
    sf::CircleShape circle(R);
    circle.setPosition(System.GetIPosition(i).x, System.GetIPosition(i).y);
    window.draw(circle);
  }
}