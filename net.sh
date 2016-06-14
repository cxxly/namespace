#!/bin/bash

# add a netwokr namespace called  test_ns
ip netns add test_ns

# create veth pair
ip link add veth0 type veth peer name veth1
ip link set veth1 netns test_ns
ip netns exec test_ns ifconfig veth1 10.1.1.1/24 up
ifconfig veth0 10.1.1.2/24 up

# ping each other
ping -c 5 10.1.1.1
ip netns exec test_ns ping -c 5 10.1.1.2

# remove test_ns
ip netns delete test_ns
