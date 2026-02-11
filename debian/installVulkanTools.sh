sudo apt -y install python3 python3-pip cmake

cd ~ 
mkdir -p sys && cd sys 
git clone https://github.com/KhronosGroup/Vulkan-Tools.git
cd Vulkan-Tools

cmake -S . -B build -D UPDATE_DEPS=ON -D BUILD_WERROR=ON -D BUILD_TESTS=ON -D CMAKE_BUILD_TYPE=Debug
cmake --build build --config Debug

sudo cmake --install build/ --config Release --prefix /usr
