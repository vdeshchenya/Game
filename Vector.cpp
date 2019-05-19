#include "Vector.h"

Vector Vector::operator-(const Vector &vec) const {
  return Vector(this->x - vec.x, this->y - vec.y);
}

Vector Vector::operator+(const Vector &vec) const {
  return Vector(this->x + vec.x, this->y + vec.y);
}

void Vector::operator+=(const Vector &a) {
  this->x += a.x;
  this->y += a.y;
}

void Vector::operator-=(const Vector &a) {
  this->x -= a.x;
  this->y -= a.y;
}

void Vector::operator*=(const double &c) {
  this->x *= c;
  this->y *= c;
}

void Vector::SetRandXYZ(const double &mini, const double &maxy) {
  x = static_cast<double>(rand()) * (maxy - mini) / RAND_MAX + mini;
  y = static_cast<double>(rand()) * (maxy - mini) / RAND_MAX + mini;
}

double Vector::GetLen2() const {
  return x * x + y * y;
}