# custom-vpc

1. Custom VPC
    - CIDR block: 10.0.0.0/24

2. Subnet
    - Public subnet
      CIDR block: 10.0.0.0/28
    
    - Private subnet
      CIDR block: 10.0.0.16/28

3. IGW
    - Attach the IGW to custom vpc

4. Custom route table
    - Add route to internet via IGW
      Associate public subnet with custom RT
      
5. Security group
    - Allow inbond traffic from 22 (ssh), 80 (http) & 443 (https) from internet

6. Instance
    - Launch an t2.micro Ubuntu EC2
      Associate with the public subnet

 