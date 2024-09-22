import oci

# Configure the OCI client
config = oci.config.from_file()  # Default location: ~/.oci/config
object_storage_client = oci.object_storage.ObjectStorageClient(config)

# Define your bucket name and namespace
bucket_name = 'mc-server'
key = '/backups/'
namespace_name = object_storage_client.get_namespace().data

# List objects in the bucket
objects = object_storage_client.list_objects(namespace_name, bucket_name, prefix=key).data

# Filter and sort objects by filename
# Assuming filenames are in a sortable date format (e.g., YYYYMMDD)
filenames = [obj.name for obj in objects]
most_recent_file = max(filenames) if filenames else None

# Check if a most recent file was found
if most_recent_file:
    print(f"Most recent file: {most_recent_file}")
    
    # Download the most recent object
    output_file_path = f'/home/opc/mc-server/{most_recent_file}'  # Set your local destination
    with open(output_file_path, 'wb') as f:
        object_storage_client.get_object(namespace_name, bucket_name, most_recent_file).data.readinto(f)

    print(f"Downloaded {most_recent_file} to {output_file_path}")
else:
    print("No objects found in the bucket.")
