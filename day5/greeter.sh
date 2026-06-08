#!/bin/bash
echo "========================================="
echo "   Welcome back Varshitha! 👋"
echo "========================================="
echo " Date     : $(date '+%a %b %d %Y')"
echo " Uptime   : $(uptime -p)"
echo " RAM Used : $(free -h | awk 'NR==2 {print $3}') / $(free -h | awk 'NR==2 {print $2}')"
echo " Disk Used: $(df -h / | awk 'NR==2 {print $5}')"
echo " Processes: $(ps aux | wc -l) running"
echo "========================================="

