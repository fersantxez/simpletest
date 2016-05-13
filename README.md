# net-tester

Network tester. Launches iperf and netperf servers on known ports. Offers iperf, netperf, nmap and simple web server services for network testing.

Based on Alpine linux for minimal footprint.

#Usage

``` docker run --rm -p 5001:5001 -p 6001:6001 -p 80:80 -p 22:22 fernandosanchez/net-tester ```
