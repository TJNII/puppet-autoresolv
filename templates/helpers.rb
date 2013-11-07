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
#
# helpers.rb: Helper functions for autoresolv class templates
#

require 'resolv'
require 'ipaddr'

# getNameserverIPs: Return a list of nameservers for domain via NS record lookups
# PRE: addrtype is a Resolv::DNS::Resource::IN:: type
# POST: none
# RETURN VALUE: A list of IP addresses
def getNameserverIPs(domain, addrtype = Resolv::DNS::Resource::IN::A)
  myresolv = Resolv::DNS.new()

  nameserver_addresses=Array.new
  myresolv.each_resource(domain, Resolv::DNS::Resource::IN::NS) do |nsrsc|
    nameserver_addresses.push(myresolv.getresource(nsrsc.name, addrtype).address)
  end

  myresolv.close()

  return nameserver_addresses
end

# sortIPs: Sort IPs by numerical delta from localip
# PRE: ips is a list of ip addresses
# POST: none
# RETURN VALUE: A sorted list of IP addresses
def sortIPs(ips, localip)
  localip_i = IPAddr.new(localip).to_i

  # Near as I can tell Resolv::IPv4 doesn't have a .to_i or equivalent
  return ips.sort_by { |ip| (IPAddr.new(ip.to_s).to_i - localip_i).abs }
end
