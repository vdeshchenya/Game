#include "SystemOfParticles.h"#define CUDA_DEBUG#ifdef CUDA_DEBUG#define CUDA_CHECK_ERROR(err)           \if (err != cudaSuccess) {          \printf("Cuda error: %s\n", cudaGetErrorString(err));    \printf("Error in file: %s, line: %i\n", __FILE__, __LINE__);  \}                 \#else#define CUDA_CHECK_ERROR(err)#endifvoid SystemOfParticles::Init(const double &r) {  R2 = r * r;  data = new Particle[1010];  N = 2;  data[0].position = {100, 100};  data[0].speed = {0, 0};  data[1].position = {102, 110};  data[1].speed = {0, 0};}__global__void testt(int *data) {    int i = blockIdx.x * blockDim.x + threadIdx.x;//BlockDim.x = 256    int j = blockIdx.y * blockDim.y + threadIdx.y;//BlockDim.x = 256    if (i < 2000)        data[i] = j;}__global__void hrr1(Particle *data, int N, double g) {  int i = blockIdx.x * blockDim.x + threadIdx.x;//BlockDim.x = 256  if (i < N) {    double dt = 0.5;    double height = 300;    double width = 300;    data[i].speed.x += (dt / 2) * (data[i].new_acceleration.x + data[i].acceleration.x);    data[i].speed.y += (dt / 2) * (data[i].new_acceleration.y + data[i].acceleration.y);    if ((data[i].position.y > height) && data[i].speed.y > 0)      data[i].speed.y *= -1;    if ((data[i].position.x > width) && data[i].speed.x > 0)      data[i].speed.x *= -1;    if ((data[i].position.x < 0) && data[i].speed.x < 0)      data[i].speed.x *= -1;    data[i].acceleration.x = data[i].new_acceleration.x;    data[i].acceleration.y = data[i].new_acceleration.y;    data[i].position.x += dt * data[i].speed.x + (dt / 2) * dt * data[i].acceleration.x;    data[i].position.y += dt * data[i].speed.y + (dt / 2) * dt * data[i].acceleration.y;    data[i].new_acceleration.x = 0;    data[i].new_acceleration.y = -g;    data[i].new_acceleration.x -= data[i].b * data[i].speed.x;    data[i].new_acceleration.y -= data[i].b * data[i].speed.y;  }}__global__void hrr(Particle *data, int N) {  int i = blockIdx.x * blockDim.x + threadIdx.x;//BlockDim.x = 256  int j = blockIdx.y * blockDim.y + threadIdx.y;//BlockDim.x = 256  if ((i < N) && (j < i)) {    double r2 = (data[i].position.x - data[j].position.x) * (data[i].position.x - data[j].position.x)        + (data[i].position.y - data[j].position.y) * (data[i].position.y - data[j].position.y);    //if (r2 < rc * rc) {}    double fr = 24 * (pow(r2, -4) - 2 * pow(r2, -7));    data[i].new_acceleration.x += fr * (data[i].position.x - data[j].position.x) / data[i].m;    data[i].new_acceleration.y += fr * (data[i].position.y - data[j].position.y) / data[i].m;    data[j].new_acceleration.x -= fr * (data[i].position.x - data[j].position.x) / data[j].m;    data[j].new_acceleration.y -= fr * (data[i].position.y - data[j].position.y) / data[j].m;  }}void SystemOfParticles::Add(const double &x, const double &y) {  data[N].position = {x, y};  data[N].speed = {0, 0};  data[N].new_acceleration = {0, 0};  data[N].acceleration = {0, 0};  data[N].m = 1;  ++N;}void SystemOfParticles::Step(const double &width, const double &height) {    dim3 block_dim(256,1,1);//max threadid    dim3 grid_dim(N/256 + 1,N+1,1);//blockdim  /*int *test;  int *test0 = new int[2000];  CUDA_CHECK_ERROR(cudaMalloc(&test, 2000 * sizeof(int)));  for (int i = 0; i < 2000; ++i) {    test0[i] = 0;  }  CUDA_CHECK_ERROR(cudaMemcpy(test, &test0[0], 2000 * sizeof(int), cudaMemcpyHostToDevice));  testt<<<grid_dim,block_dim>>>(test);  CUDA_CHECK_ERROR(cudaMemcpy(&test0[0], test, 2000 * sizeof(int), cudaMemcpyDeviceToHost));  cudaFree(test);  for (int i = 0; i < 2000; ++i) {    std::cout << test0[i] << " ";  }  std::cout << "\n";*/  Particle *data1;  CUDA_CHECK_ERROR(cudaMalloc(&data1, 1010 * sizeof(Particle)));  CUDA_CHECK_ERROR(cudaMemcpy(data1, &data[0], 1010 * sizeof(Particle), cudaMemcpyHostToDevice));  //dim3 block_dim(128,128,1);//max threadid  //dim3 grid_dim(128,128,1);//blockdim  for (int i = 0; i < 10; ++i) {    hrr<<<grid_dim,block_dim>>>(data1, N);    hrr1<<<128,128>>>(data1, N, g);  }  CUDA_CHECK_ERROR(cudaMemcpy(&data[0], data1, 1010 * sizeof(Particle), cudaMemcpyDeviceToHost));  cudaFree(data1);}const Vector &SystemOfParticles::GetIPosition(const int &i) const { return data[i].position; }const size_t &SystemOfParticles::GetNumbersOfParticles() const { return N; }