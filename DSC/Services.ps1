# Code by Microsoft
# Breakdown by Marlon Singleton

Configuration SpoolernDHCP
# (Breakdown) Arbitrary name stating configurations intent
{
    # It is best practice to always directly import resources, even if the resource is a built-in resource.
    Import-DSCResource -Name Service # (Breakdown) Imports the DSC resouce we intent to work with
    
    Node localhost # (Breakdown) System we intend to apply these settings 
    {
        # The name of this resource block, can be anything you choose, as long as it is of type [String] as indicated by the schema.
        Service "Spooler:Running" # (Breakdown) Arbitrary name of service used to state intent
        {
            Name = "Spooler" # (Breakdown) The name of the service
            State = "Running" # (Breakdown) The desired state of the service
        }

        # To configure a second service resource block, add another Service resource block and use a unique name.
        Service "DHCP:Running"
        {
            Name = "DHCP"
            State = "Running"
        }
    }
}
