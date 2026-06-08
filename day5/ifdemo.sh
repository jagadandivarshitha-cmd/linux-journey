#!/bin/bash
#!/bin/bash
DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

if [ $DISK -gt 80 ]; then
    echo "WARNING: Disk is ${DISK}% full!"
else
    echo "Disk is fine: ${DISK}% used"
fi

