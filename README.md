# simpletest

Network tester. Launches iperf and netperf servers on known ports. Offers iperf, netperf, nmap and simple web server services for network testing.

Based on Alpine linux for minimal footprint.

#Disclaimer
This image is INSECURE and should NOT be used in production. It has root access with a default password enabled. 

#Usage

``` docker run --rm -p 5001:5001 -p 6001:6001 -p 80:80 -p 22:22 fernandosanchez/simpletest ```

#Testing examples

- iperf
  On server:
     ``` iperf -s -p [port_number] (-u) ```
     where (-u) activates UDP testing, which is TCP by default.
  On client:
     ``` iperf -i [interval] -t [time] -p [port_number] (-u) -c [remote_server_address] ```

- netperf
  On server:
     ``` netserver -p [port_number] -L [my_local_server_address] ```
  On client: 
     ``` netperf -L [my_local_client_address] -H [remote_server_address]  -t [test_type] -p [port_number] ```
     where [test_type] can be:
     - TCP_STREAM
     - UDP_STREAM
     - SCTP_STREAM
     - etc.

- nmap
  On client:
     ``` nmap [server_address] ```
