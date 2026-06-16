#!/bin/bash

LOG_FILE="$1"
REPORT="log_report_$(date +%Y%m%d).txt"

if [ -z "$1" ]; then
    echo "Usage: ./log_analyser.sh <path-to-log-file>"
    exit 1
fi

print_header() {
    echo "================================================"
    echo "        WORLDBANC LOG ANALYSER REPORT"
    echo "        Generated: $(date '+%a %b %d %Y')"
    echo "================================================"
    echo " Log file    : $LOG_FILE"
    echo " Total lines : $(wc -l < $LOG_FILE)"
    echo "------------------------------------------------"
}

count_levels() {
    ERROR=$(grep -c "ERROR" "$LOG_FILE")
    WARNING=$(grep -c "WARNING" "$LOG_FILE")
    INFO=$(grep -c "INFO" "$LOG_FILE")
    ALERT=$(grep -c "ALERT" "$LOG_FILE")

    echo " ERROR count   : $ERROR"
    echo " WARNING count : $WARNING"
    echo " INFO count    : $INFO"
    echo " ALERT count   : $ALERT"
    echo "------------------------------------------------"
}

top_errors() {
    echo " TOP 5 MOST COMMON ERROR MESSAGES:"
    grep "ERROR" "$LOG_FILE" \
        | awk '{$1=$2=$3=""; print $0}' \
        | sort \
        | uniq -c \
        | sort -rn \
        | head -5 \
        | awk '{printf "  %s. %s - %s\n", NR, $1, substr($0, index($0,$2))}'
    echo "------------------------------------------------"
}

status_check() {
    TOTAL=$(wc -l < "$LOG_FILE")
    ERROR=$(grep -c "ERROR" "$LOG_FILE")
    ERROR_PCT=$(awk "BEGIN {printf \"%.0f\", ($ERROR/$TOTAL)*100}")

    echo "------------------------------------------------"
    if [ $ERROR_PCT -gt 20 ]; then
        echo " STATUS: ⚠️  High error rate detected! ($ERROR_PCT%)"
    else
        echo " STATUS: ✅ Log levels look normal ($ERROR_PCT% errors)"
    fi
    echo "================================================"
}

# ── MAIN ─────────────────────────────────────
{
    print_header
    count_levels
    top_errors
    status_check
} | tee "$REPORT"

echo ""
echo "📄 Report saved to: $REPORT"
