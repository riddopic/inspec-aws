describe aws_dms_replication_instances do
    it { should exist }
end

describe aws_dms_replication_instances do
    its('engine_versions') { should include "3.4.4" }
    its('replication_instance_classes') { should include "dms.c4.2xlarge" }
    its('storage_types') { should include "gp2" }
    its('min_allocated_storages') { should include 5 }
    its('max_allocated_storages') { should include 6144 }
    its('default_allocated_storages') { should include 100 }
    its('included_allocated_storages') { should include 100}
    its('availability_zones') { should include "us-east-2a" }
    its('release_statuses') { should_not be_empty }
end