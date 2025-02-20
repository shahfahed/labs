# VPC Peering

## North Virginia (NV) - Ohio (OH) VPC peering

### File Structure

```
provider.tf             -   proider details & access keys of both the regions with alias

nv-vpc.tf               -   vpc, subnet

oh-vpc.tf               -   vpc, subnet

pub-security-group.tf   -   allows traffic from internet

pvt-security-group.tf   -   allows traffic traffic within the vpc and the peering vpc

peering.tf              -   peering connection

instance.tf             -   Launched instances both in pvt and pub subnets to check peering connection
```