# frozen_string_literal: true

require 'aws_backend'

class AWSSecretsManagerSecret < AwsResourceBase
  name 'aws_secretsmanager_secret'
  desc ''

  example `
    describe aws_secretsmanager_secret(secret_id: "value") do
      it { should exist }
    end
  `

  def initialize(opts = {})
    opts = { secret_id: opts } if opts.is_a?(String)
    super(opts)
    validate_parameters(required: %i(secret_id))
    raise ArgumentError, "#{@__resource_name__}: secret_id must be provided" unless opts[:secret_id] && !opts[:secret_id].empty?
    @display_name = opts[:secret_id]
    catch_aws_errors do
      resp = @aws.secretsmanager_client.describe_secret({ secret_id: opts[:secret_id] })
      @res = resp.to_h
      create_resource_methods(@res)
    end
  end

  def id
    return nil unless exists?
    @res[:id]
  end

  def exists?
    !@res.nil? && !@res.empty?
  end

  def encrypted?
    @res[:encrypted]
  end

  def to_s
    "secret_id: #{@display_name}"
  end
end