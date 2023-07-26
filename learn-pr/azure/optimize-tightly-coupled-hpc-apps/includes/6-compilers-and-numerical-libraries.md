## HPC image considerations

The recommended HPC image to use to build and run tightly coupled applications is the CentOS-HPC 7.8+ image, available in Azure Marketplace. This image comes pre-installed with Mellanox Openfabrics Enterprise Distribution (MOFED). The image features higher set limits, message passing (MPI) libraries (such as HPCX, OpenMPI, and Intel MPI), and the AMD-optimized CPU libraries (AOCL). All MPI libraries and numerical libraries are available via environment module files. You can create your own HPC image by using the Azure image builder or HashiCorp Packer, but you'll need to install MOFED to access the InfiniBand network.

## Compiler considerations

All popular compilers should work on all Azure HPC VMs. If an application's build instructions recommend a particular compiler and compiler flags, try that first before trying some other compiler optimizations. For AMD EPYC processors (for example: HB120_v2 and HB60), you need to use a relatively new compiler to ensure that it supports optimizations for this architecture. For GCC, you should use at least version 7.4 or later. If possible, use GCC 9.2.0, which is included in the CentOS-HPC image.

### Specific to HC44

The HC44 VM is a two-socket Intel Skylake processor, so we recommend using an Intel compiler if possible. If the application you're compiling is floating-point bound and you suspect the floating-point operations are dominated by fused multiply-add operations, you can try enabling AVX 512 instructions. To do so, add these compilation flags:

```bash
-O3 -xHost -xCORE-AVX512
```

### Specific to HB120_v2 and HB60

Intel compilers perform well on AMD EPYC processors. If your application is floating-point intensive, you can enable AVX2 with the following compilation flags:

```bash
-O3 --march=core-avx2
```

The AMD Optimizing Compiler suite (AOCC) is specially tuned for AMD processors and might improve performance on AMD devices.

> [!NOTE]
> AOCC compilers aren't as popular as GCC and Intel compilers. Some applications might not compile without some modifications.

## Numerical library considerations

Several HPC applications have dependencies on Basic Linear Algebra Subprograms (BLAS), Linear Algebra PACKage (LAPACK), and Fastest Fourier Transform in the West (FFTW). These numerical operations can be a significant percentage of the total floating-point operations. It's expected that you use tuned versions of these libraries instead of untuned reference implementations.

### Specific to HC44

The best tuned BLAS, LAPACK and FFTW libraries for Intel processors is contained in the Intel Math Kernel Library (MKL). The MKL environment has scripts to build FFTW wrappers, so you can access the tuned Intel FFT library via the FFTW API.

### Specific to HB120_v2 and HB60

The AMD Optimizing CPU libraries (AMD-AOCL) contain a tuned BLAS library (AMD BLIS), a tuned LAPACK (AMD libFLAME), and a tuned FFTW library (AMD FFTW). These tuned libraries are also available on the CentOS-HPC 7.8+ image in Azure Marketplace.
