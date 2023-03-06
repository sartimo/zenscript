# hehe

Simple installation and configuration automatization for pre-provisioned windows systems. Used as zero-dependecy ansible alternative.

## Architecture

1. module.psm1 contains the installation and configuration engine
2. index.ps1 contains the code that the end user need to write. The file imports the upper-level module.psm1
3. index.ps1 contains low-code functions that configure the system to the level from where it parses a JSON file which is imported using Install($path). Users can edit the file at configuration\installation.json
4. install.json contains 2 types of objects: ```applications``` and ```scripts```. Applications take 3 parameters: the name, the binary location that will be installed and its flags. Scripts however, is an object used to execute arbitary batchfiles, powershell files and what-not, so it gives the user the full control about modularity anc configurability.
