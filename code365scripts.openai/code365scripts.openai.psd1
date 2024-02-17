#
# Module manifest for module 'code365scripts.teams'
#
# Generated by: arechen
#
# Generated on: 3/17/2021
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule           = '.\code365scripts.openai.psm1'

    # Version number of this module.
    ModuleVersion        = '2.0.0.8'

    # Supported PSEditions
    CompatiblePSEditions = @("Desktop")

    # ID used to uniquely identify this module
    GUID                 = '4948e170-d2aa-4f97-9cb2-fd0f0843e473'

    # Author of this module
    Author               = 'chenxizhang'

    # Company or vendor of this module
    CompanyName          = 'Code365'

    # Copyright statement for this module
    Copyright            = '(c) code365.xyz. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'The non-official OpenAI PowerShell module. This module is used to interact with OpenAI API.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Name of the PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # ClrVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules      = @(@{ ModuleName = 'MicrosoftTeams'; ModuleVersion = '2.0.0' }, @{ModuleName = 'AzureAD'; ModuleVersion = '2.0.2.130' })

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess  = @("installdependency.ps1")

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @("New-OpenAICompletion", "New-ChatGPTConversation", "New-ImageGeneration", "New-VisionCompletion", "Submit-Prompt")

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @("New-OpenAICompletion", "New-ChatGPTConversation", "New-ImageGeneration", "New-VisionCompletion", "Submit-Prompt")

    # Variables to export from this module
    VariablesToExport    = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @("noc", "chatgpt", "chat", "dall", "image", "vc", "vision","submit")

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @("code365", "community", "china", "chenxizhang", "openai")

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/chenxizhang/openai-powershell/blob/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/chenxizhang/openai-powershell/'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = @'
- 2024-02-17    v2.0.0.8    Fixed several issues on Mac and Linux
- 2024-01-08    v2.0.0.7    Code signing the module
- 2024-01-06    v2.0.0.6    Add support to vision completion, and prompt library support. you can submit prompt by submit-prompt and use a prompt from the library in all the cmdlets.
- 2023-12-15    v2.0.0.5    Enhance support online image, add outFile parameter, add alias to environment parameter.
- 2023-12-15    v2.0.0.4    Support online prompt file (system or user prompt), and online image.
- 2023-12-15    v2.0.0.3    Add alias to engine parameter (model, or deployment)
- 2023-12-15    v2.0.0.2    Add support to gpt-4-vision to generate completion from images.
- 2023-12-04    v2.0.0.1    Fix a bug (speical character parameter definition, caused by the PowerShell 5.x compatibility)
- 2023-12-03    v2.0.0.0    Add file input function, and custom profile support, and telemetry collection support.
- 2023-11-26    v1.1.1.4    PowerShell 5.x supports.
- 2023-11-26    v1.1.1.3    Multiple environment and DALL-E 3 support, and fix a lot of bugs.
- 2023-10-23    v1.1.1.2    Fix a bug (ConvertTo-Json truncate the result)
- 2023-09-25    v1.1.1.1    Fix a bug (New-ImageGeneration, or image alias)
- 2023-09-24    v1.1.1.0    Add image generation support (New-ImageGeneration, or image alias)
- 2023-09-23    v1.1.0.9    Add dynamic configuration support for New-ChatGPTConversation,see -config parameter
- 2023-09-17    v1.1.0.8    Add verbose support
- 2023-09-10    v1.1.0.7    Fix the help doc for New-ChatGPTConversation
- 2023-09-06    v1.1.0.6    Bug fix
- 2023-09-06    v1.1.0.5    Added chat completion support.
- 2023-08-12    v1.1.0.4    Added stream support for chat
- 2021-05-13    v1.1.0.3    Small enhancements (save result to clipboard, print the system prompt, etc.)
- 2021-05-13    v1.1.0.0    Simplify the module structure
- 2023-05-07    v1.0.4.12   Fixed the network connectivity test logic
- 2023-05-07    v1.0.4.11   Added azure OpenAI supporrt for New-ChatGPTConversation function
- 2023-05-07    v1.0.4.10   Added network connectivity test logic
- 2023-03-09    v1.0.4.9    Added change logs in the description.
- 2023-03-08    v1.0.4.8    Added error handling.
'@
            # Prerelease string of this module
            # Prerelease = ''

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            # RequireLicenseAcceptance = $false

            # External dependent modules of this module
            # ExternalModuleDependencies = @("MicrosoftTeams")

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    HelpInfoURI          = 'https://github.com/chenxizhang/openai-powershell/'

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

