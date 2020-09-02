#!/bin/bash
sed -i "s/Before=network.target/After=network-pre.target/" /usr/lib/systemd/system/ufw.service
