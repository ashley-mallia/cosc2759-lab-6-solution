resource "aws_security_group" "db" {
  description = "Allow postgres traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "postgres from vpc"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow postgres"
  }
}

resource "aws_db_subnet_group" "main" {
  subnet_ids = [aws_subnet.data_az1.id, aws_subnet.data_az2.id, aws_subnet.data_az3.id]
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier      = "todo-app"
  engine                  = "aurora-postgresql"
  engine_mode             = "serverless"
  database_name           = "app"
  master_username         = "postgres"
  master_password         = "password"
  port                    = 5432
  backup_retention_period = 1
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.db.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name
}
