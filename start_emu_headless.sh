#!/bin/bash

function check_hardware_acceleration() {
  if [[ "$HW_ACCEL_OVERRIDE" != "" ]]; then
    hw_accel_flag="$HW_ACCEL_OVERRIDE"
  else
    if [[ "$OSTYPE" == "darwin"* ]]; then
      HW_ACCEL_SUPPORT=$(sysctl -a | grep -E -c '(vmx|svm)')
    else
      HW_ACCEL_SUPPORT=$(grep -E -c '(vmx|svm)' /proc/cpuinfo)
    fi

    if [[ $HW_ACCEL_SUPPORT == 0 ]]; then
      hw_accel_flag="-accel off"
    else
      hw_accel_flag="-accel on"
    fi
  fi

  echo "$hw_accel_flag"
}

function launch_emulator () {
  adb devices | grep emulator | cut -f1 | xargs -I {} adb -s {} emu kill
  options="${emulator_name} -no-window -no-snapshot -noaudio -no-boot-anim -memory 2048 ${hw_accel_flag} -camera-back none"
  if [[ "$OSTYPE" == "linux"* ]]; then
    nohup emulator $options -gpu off &
  fi
  if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "macos"* ]]; then
    nohup emulator $options -gpu swiftshader_indirect &
  fi

  if [ $? -ne 0 ]; then
    echo "Error launching emulator"
    return 1
  fi
}

hw_accel_flag=$(check_hardware_acceleration)
launch_emulator
