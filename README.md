# terraform-sandpit


connect to db via ssm:

aws ssm start-session \
    --target <db_instance_id> \
    --document-name AWS-StartPortForwardingSessionToRemoteHost \
    --parameters '{"portNumber":["5432"], "localPortNumber":["5432"]}'