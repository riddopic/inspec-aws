aws_elb2_listener_arn = attribute(:aws_elb2_listener_arn, value: '', description: '')
aws_elb2_certificate_arn = attribute(:aws_elb2_certificate_arn, value: '', description: '')

control 'aws-_elb2_listener_certificates1-1.0' do

  impact 1.0
  title 'Ensure AWS ELBV2 Listener Certificates has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: aws_elb2_listener_arn) do
    it { should exist }
  end
end
  
control 'aws-_elb2_listener_certificates2-1.0' do

  impact 1.0
  title 'Ensure AWS ELBV2 Listener Certificates has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_certificates(listener_arn: aws_elb2_listener_arn) do
    its('certificate_arns') { should include aws_elb2_certificate_arn }
    its('is_defaults') { should include true }
  end
end