# Cookbook:: grafana
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

grafana_install "grafana"

service "grafana-server" do
  action [:enable, :start]
  subscribes :restart, ["template[/etc/grafana/grafana.ini]", "template[/etc/grafana/ldap.toml]"], :delayed
end

grafana_datasource "cloudwatch" do
  datasource(
    type: "cloudwatch",
	access: "direct",
	region: "eu-west-3",
	isdefault: true
  )
  action :create
end

grafana_dashboard "aws-ec2-dashboard" do
  dashboard(
    path: "/home/ubuntu/Chef_ec2/dashboards/aws-ec2_rev4.json"
  )
end

grafana_dashboard "aws-auto-dashboard" do
  dashboard(
    path: "/home/ubuntu/Chef_ec2/dashboards/aws-auto-scaling_rev4.json"
  )
end