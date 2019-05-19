#include <cmath>
#include "Particle.h"
#include <iomanip>

Vector GetForceLD(const Particle &a, const Particle &b, const double& rc, const double& R2) {
  double r2 = GetDist2(a, b);
  if (r2 < rc * rc) {
    double fr = 24 * (pow(r2, -4) - 2 * pow(r2, -7));
    return fr * Vector((a.position - b.position).x, (a.position - b.position).y);
  } else
    return Vector(0,0);
}

double GetDist2(const Particle &a, const Particle &b) {
  return (a.position - b.position).GetLen2();
}