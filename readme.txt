# autoresolv: Generate a resolv.conf from $resolv_domain NS records
#             Nameserver records will be sorted by closest nameserver first, via IP math
#             Currently only supports IPv4
# REQUIREMENTS:
#   $resolv_domain is the domain to pull NS records from
#      NOTE: $domain was not used as it contains any subdomains, which likely will not have NS records
#   $fallback_nameserver_ips is an array of nameserver IPs to always include in the resolv.conf
#
#   All nameservers in the $resolv_domain NS records and fallback_nameserver_ips should allow recursion
#      from the clients.  (Not really a module requirement, but you're gonna have a bad time without this.)
#
# 2013 TJNII
