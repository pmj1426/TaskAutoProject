#!/bin/bash

function spawn(){
  ./executables/APM1 127.0.0.1 &
  APM1=$!
  ./executables/APM2 127.0.0.1 &
  APM2=$!
  ./executables/APM3 127.0.0.1 &
  APM3=$!
  ./executables/APM4 127.0.0.1 &
  APM4=$!
  ./executables/APM5 127.0.0.1 &
  APM5=$!
  ./executables/APM6 127.0.0.1 &
  APM6=$!
}

function cleanup(){
  kill $APM1
  kill $APM2
  kill $APM3
  kill $APM4
  kill $APM5
  kill $APM6
}

trap "cleanup" EXIT
