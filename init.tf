data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  #first part of local config file
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF

    #!/bin/bash
    rm -f /etc/app/dist/conf.toml

    cat > /etc/app/dist/conf.toml << EOL
    "DbUser" = "'${aws_rds_cluster.postgresql.master_username}'"
    "DbPassword" = "${aws_rds_cluster.postgresql.master_password}'"
    "DbName" = "app"
    "DbPort" = "5432"
    "DbHost" = "'${aws_rds_cluster.postgresql.endpoint}'"
    "ListenHost" = "0.0.0.0"
    "ListenPort" = "80"
    EOL

    cat > /usr/lib/systemd/system/techtestapp.service << EOL
    [Unit]
    Description=TechTestApp
    Requires=network-online.target
    After=network-online.target

    [Service]
    WorkingDirectory=/etc/app/dist
    Type=simple
    ExecStart=/etc/app/dist/TechTestApp serve
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    EOL

    systemctl daemon-reload
    sudo systemctl restart techtestapp
    EOF
  }
}