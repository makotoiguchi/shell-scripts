########## basic

# Ping 3x with 5sec timeout
ping -c 3 -W 5 IP
    # OK - 0% packet loss
    # NOK - > 0% packet loss

# telnet - test port
telnet IP port
    # OK - telnet terminal opened
    # NOK - connection refused, no route to host

# cat /dev - test port
cat < /dev/tcp/IP/PORT
    # OK - empty
    # NOK - no route to host


########## Route

# network path to host
traceroute HOST

tracepath HOST


########## TLS and certificates

# secure connection / get server certificate
openssl s_client -connect IP:PORT
    # OK - connection opened, Session ID received
    # NOK - bad file descriptor

# test protocol
openssl s_client -connect IP:PORT -PROTOCOL
    # PROTOCOL: ssl3, tls1, tls1_1, tls1_2
    # OK - conneciton opened, Session ID received
    # NOK - connection closed, Session ID empty

# get certificate chain (if any)
openssl s_client -connect IP:PORT -showcerts

# get certificate details
openssl s_client -connect IP:PORT | openssl x509 -text


