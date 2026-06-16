# Log Analyser Script

Analyses Linux log files and generates a clean summary report.

## What it does
- Counts ERROR, WARNING, INFO, ALERT occurrences
- Finds top 5 most common error messages
- Calculates error rate and warns if above 20%
- Saves timestamped report to .txt file

## How to run
chmod +x log_analyser.sh
./log_analyser.sh /path/to/logfile.log

## Tested on
Worldbanc private logs — 10,000 lines each

## Built by
Varshitha — Linux Journey Milestone 3
