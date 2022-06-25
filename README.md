# learning-cuda

To compile cuda code using nvcc:

```bash
nvcc -o add-vectors addVectors.cu -run 
```

We can monitor the code buttlenecks using Nsight profiling tool.

```bash
nsys profile --stats=true -o add-vectors-report ./add-vectors
```

More coming soon...
