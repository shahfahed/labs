resource "aws_vpc_peering_connection" "nv-oh-peering" {
    provider = aws.nv-region
    vpc_id = aws_vpc.nv-vpc.id
    peer_vpc_id = aws_vpc.oh-vpc.id
    peer_region = "us-east-2"
    auto_accept   = false # Since it's across regions, manual acceptance is required
    tags = {
        Name = "nv-oh-peering"
    }
}

resource "aws_vpc_peering_connection_accepter" "peer_accept" {
    provider = aws.oh-region
    vpc_peering_connection_id = aws_vpc_peering_connection.nv-oh-peering.id
    auto_accept = true
    tags = {
        Name = "peer_accepter"
    }
}