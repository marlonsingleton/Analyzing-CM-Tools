# Code from Microsoft
# Breakdown by Marlon Singleton

Configuration HelloWorld { 
# (Breakdown) The configuration name "HelloWorld" is arbitrary and only used to identify intent

    # (Breakdown) Import the module that contains the File resource.
    Import-DscResource -ModuleName PsDesiredStateConfiguration # (Breakdown) Import DSC module in PowerShell

    # The Node statement specifies which targets to compile MOF files for, when this configuration is executed.
    Node 'localhost' {
    # (Breakdown) The node states which systems to apply this configuration

        # The File resource can ensure the state of files, or copy them from a source to a destination with persistent updates.
        File HelloWorld {
        # (Breakdown) The file name "HelloWorld" is arbitrary and only used to identify intent
        
            DestinationPath = "C:\Temp\HelloWorld.txt" # (Breakdown) File Path
            Ensure = "Present" # (Breakdown) If File Path Doesn't Exist, create it
            Contents   = "Hello World from DSC!" # (Breakdown) Enter the following text into the file.
        }
    }
}
