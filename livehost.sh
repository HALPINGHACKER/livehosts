#!/bin/bash

# Usage: ./livehosts.sh <domain>
# Example: ./livehosts.sh example.com

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain="$1"

# Wordlist containing potential subdomains to check
wordlist="subdomains.txt"

# Function to check if a subdomain is live
check_subdomain() {
    subdomain="$1.$domain"
    if nslookup "$subdomain" &> /dev/null; then
        echo "$subdomain is live"
    fi
}

# Loop through the wordlist and check each subdomain
while IFS= read -r line; do
    check_subdomain "$line"
done < "$wordlist"

