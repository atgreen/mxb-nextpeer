# mxb-nextpeer

A simple web service to provide the address of a single bitcoin
node. Calling the / endpoint will result in a simple ASCII text
response containing an IPv4 address string.

We use a single DNS seed provider, and query it through Google's
DNS-over-HTTPS service.

# TODO

* Draw from a pool of providers
* Add peer blacklist support
* Handle failure modes

