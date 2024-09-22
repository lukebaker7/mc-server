import mcrcon
from dotenv import load_dotenv
import os
import oci
import time


load_dotenv()
host = os.getenv('HOST')
pw = os.getenv('PASS')
instance = os.getenv('INSTANCE')

with mcrcon.MCRcon(host=host, password=pw, port=25575) as mcr:
    response = mcr.command("list")
    # Example response: "There are 0 of a max 20 players online: "

    num_players = int(response.split()[2])
 

    if num_players < 1:
        mcr.command('save-all')
        time.sleep(5)
        response = mcr.command('stop')
        time.sleep(5)
        #shut down
        instance_id = instance

        # Load the default configuration from ~/.oci/config
        config = oci.config.from_file()

        # Create a ComputeClient
        compute_client = oci.core.ComputeClient(config)

        # Stop the instance
        response = compute_client.instance_action(instance_id, "STOP")
        print(f"Stopping instance: {instance_id}")

    else:
        print(response)