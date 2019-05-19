#pragma once
#include <iostream>
#include <cmath>
#include <random>
#include <ctime>

class Vector {
 public:
  Vector(const double& x_ = 0, const double& y_ = 0) : x(x_), y(y_) {};
  double x, y;
  void SetRandXYZ(const double &mini, const double &maxy);
  double GetLen2() const;

  template <class T>
  friend Vector operator*(const T& a, const Vector& vec);

  template <class T>
  friend Vector operator/(const Vector& vec, const T& a);

  Vector operator-(const Vector& vec) const;
  Vector operator+(const Vector& vec) const;
  void operator+=(const Vector &a);
  void operator*=(const double &c);
  void operator-=(const Vector &a);
};

template <class T>
Vector operator*(const T& a, const Vector& vec) {
  return {vec.x * a, vec.y * a};
}

template <class T>
Vector operator/(const Vector& vec, const T& a) {
  return {vec.x / a, vec.y / a};
}