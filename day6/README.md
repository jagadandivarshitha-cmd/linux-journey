# System Health Check Script

A bash script that generates a full system health report.

## What it does
- Checks CPU load, RAM and Disk usage
- Lists top 5 largest files in /var/log
- Shows top 5 processes by memory
- Warns if disk or RAM exceeds 80%
- Saves report to a timestamped .log file

## How to run
chmod +x health_check.sh
./health_check.sh

## Built by
Varshitha — Linux Journey Day 6
