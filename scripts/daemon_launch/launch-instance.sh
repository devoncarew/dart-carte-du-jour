set -x

STARTUP_SCRIPT=startup-script.sh
gcutil --service_version="v1" --project="dart-carte-du-jour" addinstance "daemon-isolate" --zone="us-central1-a" --machine_type="g1-small" --network="default" --external_ip_address="ephemeral" --service_account_scopes="https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/compute,https://www.googleapis.com/auth/devstorage.full_control" --image="https://www.googleapis.com/compute/v1/projects/dart-carte-du-jour/global/images/dart-daemon-isolate-v1" --persistent_boot_disk="true" --auto_delete_boot_disk="true" --metadata_from_file=startup-script:$STARTUP_SCRIPT
