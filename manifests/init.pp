# Copyright 2013 Tom Noonan II (TJNII)
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# 
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
