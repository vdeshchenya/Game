#pragma once
#include "Particle.h"
#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>
#include <fstream>
#include <omp.h>
#include <set>

class SystemOfParticles {
 public:
  //Main functions
  void Init(const double& r);
  void Step(const double &width, const double &height);
  void Add(const double &x, const double &y);
  //Access functions
  const Vector &GetIPosition(const int &i) const;
  const size_t &GetNumbersOfParticles() const;
 private:
  std::vector<Particle> data;
  size_t N = 0;
  double dt = 0.5;
  double rc = 7;
  double g = -0.03;
  double R2;
};