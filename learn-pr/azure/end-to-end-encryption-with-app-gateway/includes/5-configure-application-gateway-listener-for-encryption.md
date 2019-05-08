In this unit, you will see how the listener is setup. The listener is needed to listen for traffic to our application, which is then routed to our servers via the backend pool.

The listener is setup on to listen on the IP address that is configured for the listener, it listens for traffic on the specific port and uses the private certificate to decrypt the traffic before passing the traffic on to the backend pool.

To create the listener you need to configure:
    - Frontend IP configuration
    - Frontend port (443 for TLS/SSL)
    - Private certificate