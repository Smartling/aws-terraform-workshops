# 1. Create security group for Jenkins server.
# 2. Create inbound rule in security group to allow incoming connections via 8000 tcp port from 0.0.0.0/0 network.
# 3. Create outbound rule in security group to allow outgoing connections from instance via any ports/protocols.

resource "" "" {

  # ...

  # keep these arguments as is
  description = "Jenkins security group (W4)."
}
