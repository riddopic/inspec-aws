# frozen_string_literal: true

require 'aws_backend'

class AwsIamManagedPolicies < AwsResourceBase
  name 'aws_iam_managed_policies'
  desc 'Verifies settings for a collection AWS Iam managed Policies'
  example '
    describe aws_iam_managed_policies do
      it { should exist }
    end
  '

  attr_reader :table

  FilterTable.create
             .register_column(:arns,                field: :arn)
             .register_column(:attachment_counts,   field: :attachment_count)
             .register_column(:default_version_ids, field: :default_version_id)
             .register_column(:policy_names,        field: :policy_name)
             .register_column(:policy_ids,          field: :policy_id)
             .register_column(:permissions_boundary_usage_count, field: :permissions_boundary_usage_count)
             .register_column(:description,      field: :description)
             .register_column(:create_date,      field: :create_date)
             .register_column(:update_date,      field: :update_date)
             .register_column(:update_date,      field: :update_date)
             .install_filter_methods_on_resource(self, :table)

  def initialize(opts = {})
    super(opts)
    validate_parameters
    parameters = {}
    @table = fetch_data(parameters)
  end

  def fetch_data(parameters = {})
    iam_policy_rows = []
    loop do
      catch_aws_errors do
        @response = @aws.iam_client.list_entities_for_policy
      end
      return iam_policy_rows if !@response || @response.empty?
      @response.policies.each do |p|
        iam_policy_rows += [{ arn:                              p.arn,
                              attachment_count:                 p.attachment_count,
                              default_version_id:               p.default_version_id,
                              policy_name:                      p.policy_name,
                              policy_id:                        p.policy_id,
                              permissions_boundary_usage_count: p.permissions_boundary_usage_count,
                              description:                      p.description,
                              create_date:                      p.create_date,
                              update_date:                      p.update_date,
                              tags:                             p.tags }]
      end
      break unless @response.is_truncated
      break unless @response.marker
      parameters[:marker] = @response.marker
    end
    @table = iam_policy_rows
  end
end