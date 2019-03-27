# Build instructions:

### Dependencies:
  - Boost 1.54+

## Windows:

Windows builds made by us are available here: https://github.com/crypticcoinvip/nheqminer/releases

Download and install:
- [CUDA SDK](https://developer.nvidia.com/cuda-downloads) (if not needed remove **USE_CUDA_TROMP** and **USE_CUDA_DJEZO** from **nheqminer** Preprocessor definitions under Properties > C/C++ > Preprocessor)
- Visual Studio 2015 Community
- boost 1.62: https://boost.teeks99.com/bin/1.62.0/
- 64 bit version only

Open **nheqminer.sln** under **nheqminer/nheqminer.sln** and build. You will have to build Release cuda_djezo project, then select Release and build nheqminer.

### Enabled solvers:
  - USE_CUDA_DJEZO

If you don't wan't to build with all solvers you can go to **nheqminer Properties > C/C++ > Preprocessor > Preprocessor Definitions** and remove the solver you don't need.

## Linux

Work in progress.

Working solvers: CPU_TROMP, CUDA_TROMP, CUDA_DJEZO

## Linux (Ubuntu 14.04 / 16.04) Build CPU_TROMP:

 - Open terminal and run the following commands:
   - `sudo apt-get install cmake build-essential libboost-all-dev`
   - `git clone https://github.com/crypticcoinvip/nheqminer.git`
   - `cd nheqminer`
   - `cmake -DUSE_CPU_XENONCAT=OFF -DUSE_CUDA_TROMP=OFF -DUSE_CPU_TROMP=ON -DUSE_CUDA_DJEZO=OFF .`
   - `make -j $(nproc)`

## Linux (Ubuntu 14.04 / 16.04) Build CUDA_DJEZO:

 - Open terminal and run the following commands:
   - **Ubuntu 14.04**:
     - `wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_8.0.44-1_amd64.deb`
     - `sudo dpkg -i cuda-repo-ubuntu1404_8.0.44-1_amd64.deb`
   - **Ubuntu 16.04**:
     - `wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.44-1_amd64.deb`
     - `sudo dpkg -i cuda-repo-ubuntu1604_8.0.44-1_amd64.deb`
   - `sudo apt-get update`
   - `sudo apt-get install cuda`
   - `sudo apt-get install cuda-toolkit-8-0`
   - `sudo apt-get install cmake build-essential libboost-all-dev`
   - `git clone https://github.com/crypticcoinvip/nheqminer.git`
   - `cd nheqminer && CUDA_CUDART_LIBRARY="/usr/local/cuda/lib64/libcudart.so" && cmake -DUSE_CPU_XENONCAT=OFF  -DUSE_CUDA_TROMP=OFF -DUSE_CPU_TROMP=ON -DUSE_CUDA_DJEZO=ON -DCMAKE_BUILD_TYPE=Release -DCUDA_CUDART_LIBRARY=CUDA_CUDART_LIBRARY . && make -j $(nproc)`
   - If your GPU compute capability isn't supported by default, specify it explicitly (for example 80) like so `cd nheqminer && CUDA_CUDART_LIBRARY="/usr/local/cuda/lib64/libcudart.so" && cmake COMPUTE=80 -DUSE_CPU_XENONCAT=OFF  -DUSE_CUDA_TROMP=OFF -DUSE_CPU_TROMP=ON -DUSE_CUDA_DJEZO=ON -DCMAKE_BUILD_TYPE=Release -DCUDA_CUDART_LIBRARY=CUDA_CUDART_LIBRARY . && make -j $(nproc)`

   
# Run instructions:

Parameters: 
	-h		Print this help and quit
	-l [location]	Stratum server:port
	-u [username]	Username (bitcoinaddress)
	-a [port]	Local API port (default: 0 = do not bind)
	-d [level]	Debug print level (0 = print all, 5 = fatal only, default: 2)
	-b [hashes]	Run in benchmark mode (default: 200 iterations)

CPU settings
	-t [num_thrds]	Number of CPU threads
	-e [ext]	Solver to use (0 = SSE2 tromp, 1 = AVX tromp, 2 = AVX2 xenoncat)

NVIDIA CUDA settings
	-ci	CUDA info\
  -cv Solver to use (0 = GPU-djezo, 1 = GPU-tromp)
	-cd [devices]	Enable CUDA mining on spec. devices
	-cb [blocks]	Number of blocks
	-ct [tpb]	Number of threads per block
Example: -cd 0 2 -cb 12 16 -ct 64 128

If run without parameters, miner will start mining with 75% of available logical CPU cores. Use parameter -h to learn about available parameters:

Example to run benchmark on your CPU:

        nheqminer -b
        
Example to mine on your CPU AVX1 with your own CrypticCoin address and worker1 on CrypticPool server, using 4 threads (make sure your executable contains CPU-tromp solver):

        nheqminer -l crypticpool.com:44444 -u YOUR_CRYPTICCOIN_ADDRESS_HERE.worker1 -e 1 -t 4

Example to mine on your GPU with your own CrypticCoin address and worker3 on CrypticPool server, using 8 threads (make sure your executable contains GPU-djezo solver):

        nheqminer -l crypticpool.com:55555 -u YOUR_CRYPTICCOIN_ADDRESS_HERE.worker3 -cv 0 -cd 0

<i>Note: if you have a 4-core CPU with hyper threading enabled (total 8 threads) it is best to run with only 6 threads (experimental benchmarks shows that best results are achieved with 75% threads utilized)</i>

