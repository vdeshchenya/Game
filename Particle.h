#pragma once
#include "Vector.h"

class Particle {
 public:
  Particle(const int& m_ = 1, const double& b_ = 0.5) : m(m_), b(b_) {};
  Vector position;
  Vector speed;
  Vector acceleration;
  Vector new_acceleration;
  int m = 1;
  double b = 0.6;
};

Vector GetForceLD(const Particle &a, const Particle &b, const double& rc, const double& R2);
double GetDist2(const Particle &a, const Particle &b);