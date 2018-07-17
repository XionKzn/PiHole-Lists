# PiHole-Lists
This is my personal PiHole Block/White-lists used to more easily update PiHole lists. Entries in the files are gathered randomly from multiple sources for my own personal use.

## PiHole
https://pi-hole.net

## Find anudeepND at:
https://github.com/anudeepND/whitelist



## PiHole_HOSTS_Spyware.txt
**PiHole_HOSTS_Spyware.txt** Is taken Directly from Windows Hosts File.

## Whitelist.txt
**Whitelist.txt** Are domains I found PiHole blocking but causing Legit software from functioning correctly (Origin, Steam etc. sign-in).

## Blocklist.txt
**Blocklist.txt** Is a list of sites I found needed to be blocked for somereason (Flagged as malicious by some online service, my AV or router) that's not currently on the default blocklists.

## PiHole_Commonly_Whitelisted_Domains.txt
**PiHole_Commonly_Whitelisted_Domains.txt** Are taken directly from the PiHole forum and added into an easy to use list (run pihole -w to add).
> example | ~$ pihole - w google.com facebook.com intel.com
