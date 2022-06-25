#include <stdio.h>

void initWith(float num, float* a, int N){

	for(int i=0; i<N; ++i)
		a[i] = num;

}

__global__
void addVectorsInto(float* results, float* a, float* b,int N){

	int withinGrid = threadIdx.x + blockIdx.x*blockDim.x;
	int gridStrid = gridDim.x * blockDim.x;

	for(int i=withinGrid; i<N; i+=gridStrid)
		results[i] = a[i] + b[i];
}

void checkElementsAre(float target, float *array, int N){
  
	for(int i = 0; i < N; i++){
		if(array[i] != target){
			printf("FAIL: array[%d] - %0.0f does not equal %0.0f\n", i, array[i], target);
			exit(1);
		}
	}
	printf("SUCCESS! All values added correctly.\n");
}

int main(){

	const int N = 2 << 20;
	size_t size = N * sizeof(float);
	float* a, *b, *c;

	cudaMallocManaged(&a, size);
	cudaMallocManaged(&b, size);
	cudaMallocManaged(&c, size);

	initWith(3, a, N);
	initWith(4, b, N);
	initWith(0, c, N);

	addVectorsInto<<<32, 1024>>>(c, a, b, N);
	cudaDeviceSynchronize();

	checkElementsAre(7, c, N);

	cudaFree(a);
	cudaFree(b);
	cudaFree(c);

	return 0;
}
