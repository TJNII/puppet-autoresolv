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
#   ipaddress_internal is provided by the commonfacts module
#
# 2013 TJNII
#
class autoresolv (
  $resolv_domain,
  $fallback_nameserver_ips = [],
  $resolv_sort_ipaddress = $ipaddress_internal,
  ) {
    
    file { '/etc/resolv.conf':
      path    => '/etc/resolv.conf',
      ensure  => file,
      content  => template("autoresolv/resolv.conf.erb"),
   }
}
