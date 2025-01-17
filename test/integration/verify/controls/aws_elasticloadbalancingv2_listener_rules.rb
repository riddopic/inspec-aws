listener_arn = attribute(:listener_arn, value: '', description: '')

control 'aws-elbv2-listener-rules1-1.0' do

  impact 1.0
  title 'Ensure AWS ELBv2 Listerner Rules has the correct properties.'

  describe aws_elasticloadbalancingv2_listener_rules(listener_arn: listener_arn) do
    it { should exist }
  end
end
  
control 'aws-elbv2-listener-rules2-1.0' do
  
    impact 1.0
    title 'Ensure AWS ELBv2 Listerner Rules has the correct properties.'
  
    describe aws_elasticloadbalancingv2_listener_rules(listener_arn: listener_arn) do
      its('rule_arns') { should include aws_elbv2_rule_arn }
      its('priorities') { should include "100" }
      its('conditions') { should_not be_empty }
      its('actions') { should_not be_empty }
      its('is_defaults') { should include false}
  end
end