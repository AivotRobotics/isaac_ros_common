# SPDX-FileCopyrightText: NVIDIA CORPORATION & AFFILIATES
# Copyright (c) 2023-2024 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

# Common flags and cmake commands for all Isaac ROS packages.
message(STATUS "Loading isaac_ros_common extras")

# The FindCUDA module is removed
if(POLICY CMP0146)
  cmake_policy(SET CMP0146 OLD)
endif()

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
endif()

# Default to Release build
if(NOT CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()
message( STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}" )

# for #include <cuda_runtime.h>
set(CUDA_MIN_VERSION "11.4")
find_package(CUDA REQUIRED)
include_directories("${CUDA_INCLUDE_DIRS}")

# Setup cuda architectures
# Target Ada is CUDA 11.8 or greater
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  if(${CMAKE_SYSTEM_PROCESSOR} STREQUAL "aarch64")
    set(CMAKE_CUDA_ARCHITECTURES "87")
  elseif(${CUDA_VERSION} GREATER_EQUAL 11.8)
    set(CMAKE_CUDA_ARCHITECTURES "89;86;80;75;70")
  else()
    set(CMAKE_CUDA_ARCHITECTURES "86;80;75;70")
  endif()
endif()
message(STATUS "CUDA architectures: ${CMAKE_CUDA_ARCHITECTURES}")

