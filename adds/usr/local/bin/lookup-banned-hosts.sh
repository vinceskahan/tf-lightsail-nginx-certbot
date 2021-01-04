for f in `sudo iptables -L -n -v | grep unreachable|awk '{print $8}'`; do geoiplookup $f; done | sort | uniq -c
