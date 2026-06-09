#!/bin/bash

# ── CONFIG ──────────────────────────────────────
LOGFILE="health_report_$(date +%Y%m%d_%H%M%S).log"
THRESHOLD=80

# ── FUNCTIONS ───────────────────────────────────
print_line() {
    echo "---------------------------------------------"
}

print_header() {
    echo "============================================="
    echo "     SYSTEM HEALTH REPORT"
    echo "     Generated: $(date)"
    echo "============================================="
}

# system info

system_info() {
    echo " HOST     : $(hostname)"
    echo " UPTIME   : $(uptime -p)"
    print_line
}

# cpu & ram & disk

resource_usage() {
    # CPU
    CPU=$(uptime | awk -F'load average:' '{print $2}')
    echo " CPU LOAD : $CPU"

    # RAM
    RAM_USED=$(free -h | awk 'NR==2 {print $3}')
    RAM_TOTAL=$(free -h | awk 'NR==2 {print $2}')
    RAM_PCT=$(free | awk 'NR==2 {printf "%.0f", $3/$2*100}')
    echo " RAM      : $RAM_USED used of $RAM_TOTAL (${RAM_PCT}%)"

    # DISK
    DISK=$(df -h / | awk 'NR==2 {print $5}')
    echo " DISK     : $DISK used on /"
    print_line
}

# largest file

largest_files() {
    echo " TOP 5 LARGEST FILES IN /var/log:"
    sudo find /var/log -type f -exec du -h {} + 2>/dev/null \
        | sort -rh \
        | head -5 \
        | awk '{print "  " NR ". " $1 "  " $2}'
    print_line
}

# process

process_info() {
    echo " RUNNING PROCESSES : $(ps aux | wc -l)"
    echo " TOP 5 PROCESSES BY MEMORY:"
    echo "  PID   %MEM  COMMAND"
    ps aux --sort=-%mem \
        | awk 'NR>1 && NR<=6 {printf "  %-6s %-5s %s\n", $2, $4, $11}'
    print_line
}

# Status check

status_check() {
    DISK_NUM=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    RAM_NUM=$(free | awk 'NR==2 {printf "%.0f", $3/$2*100}')

    if [ $DISK_NUM -gt $THRESHOLD ] || [ $RAM_NUM -gt $THRESHOLD ]; then
        echo " STATUS: ⚠️  WARNING — Check resources!"
    else
        echo " STATUS: ALL SYSTEMS HEALTHY ✅"
    fi
    echo "============================================="
}

# ── MAIN ────────────────────────────────────────
{
    print_header
    system_info
    resource_usage
    largest_files
    process_info
    status_check
} | tee "$LOGFILE"

echo ""
echo "📄 Report saved to: $LOGFILE"


