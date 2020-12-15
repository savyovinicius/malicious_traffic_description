#!/bin/bash

for f in *cnc.output; do
	echo "$f CNC hosts:"
	grep -o -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $f | sort | uniq | wc -l
done

for f in *scan.output; do
	echo "$f scanned hosts:"
	grep -o -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" $f | sort | uniq | wc -l
done

for f in *loader.output; do
	echo "$f infected hosts:"
	grep -E "^((OK)|(ERR\|.*\|1[89]))" $f | grep -o -E "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sort | uniq | wc -l
done

for f in *flows.output; do
	echo "$f generated DDoS packets"
	grep -E "nw_dst=((172\.217\.29\.110)|(52\.94\.209\.132)|(130\.149\.17\.8)|(93\.184\.216\.34)|(35\.174\.82\.237)|(34\.240\.169\.254)|(176\.32\.98\.203))" $f | grep -o -E "n_packets=[0-9]+" | grep -o -E "[0-9]+" | awk '{s+=$1} END {print s}'

	echo "$f transmited DDoS packets"
	if [[ $f == *"open"* ]]; then
		grep -E "nw_dst=((172\.217\.29\.110)|(52\.94\.209\.132)|(130\.149\.17\.8)|(93\.184\.216\.34)|(35\.174\.82\.237)|(34\.240\.169\.254)|(176\.32\.98\.203))" $f | grep -o -E "n_packets=[0-9]+" | grep -o -E "[0-9]+" | awk '{s+=$1} END {print s}'
        else
		grep -E "nw_dst=((172\.217\.29\.110)|(52\.94\.209\.132)|(130\.149\.17\.8)|(93\.184\.216\.34)|(35\.174\.82\.237)|(34\.240\.169\.254)|(176\.32\.98\.203))" $f | grep -i -E "actions=NORMAL"| grep -o -E "n_packets=[0-9]+" | grep -o -E "[0-9]+" | awk '{s+=$1} END {print s}'
        fi
done
