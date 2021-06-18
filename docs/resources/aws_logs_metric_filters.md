---
title: About the aws_logs_metric_filters Resource
platform: aws
---

# aws\_logs\_metric\_filters

Use the `aws_logs_metric_filters` InSpec audit resource to test properties of a plural AWS Logs Metric Filters.

The AWS::Logs::MetricFilter resource specifies a metric filter that describes how CloudWatch Logs extracts information from logs and transforms it into Amazon CloudWatch metrics. If you have multiple metric filters that are associated with a log group, all the filters are applied to the log streams in that group.

## Syntax

Ensure that a filter name exists.

    describe aws_logs_metric_filters do
      it { should exist }
    end

## Parameters

For additional information, see the [AWS documentation on AWS Logs MetricFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-logs-metricfilter.html).

## Properties

| Property | Description|
| --- | --- |
| filter_names | The name of the metric filter. |
| filter_patterns | A symbolic description of how CloudWatch Logs should interpret the data in each log event. For example, a log event can contain timestamps, IP addresses, strings, and so on. You use the filter pattern to specify what to look for in the log event message. |
| metric_transformations | The metric transformations. |
| creation_times | The creation time of the metric filter, expressed as the number of milliseconds after Jan 1, 1970 00:00:00 UTC. |
| log_group_names | The name of the log group. |

## Examples

### Ensure a filter name is available.
    describe aws_logs_metric_filters do
      its('filter_names') { should include 'FilterName' }
    end

### Ensure a log group name is available.
    describe aws_logs_metric_filters do
        its('log_group_names') { should include 'LogGroupName' }
    end

## Matchers

This InSpec audit resource has the following special matchers. For a full list of available matchers, please visit our [Universal Matchers page](https://www.inspec.io/docs/reference/matchers/).

The controls will pass if the `describe` method returns at least one result.

### exist

Use `should` to test that the entity exists.

    describe aws_logs_metric_filters do
      it { should exist }
    end

Use `should_not` to test the entity does not exist.
      
    describe aws_logs_metric_filters do
      it { should_not exist }
    end

### be_available

Use `should` to check if the filter name is available.

    describe aws_logs_metric_filters do
      it { should be_available }
    end

## AWS Permissions

Your [Principal](https://docs.aws.amazon.com/IAM/latest/UserGuide/intro-structure.html#intro-structure-principal) will need the `cloudwatchlogs:client:describe_metric_filters` action with `Effect` set to `Allow`.