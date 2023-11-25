function New-OpenAICompletion {
    <#
    .SYNOPSIS
        Get completion from OpenAI API
    .DESCRIPTION
        Get completion from OpenAI API, you can use this cmdlet to get completion from OpenAI API.The cmdlet accept pipeline input. You can also assign the prompt, api_key, engine, endpoint, max_tokens, temperature, n parameters.
    .PARAMETER prompt
        The prompt to get completion from OpenAI API
    .PARAMETER api_key
        The api_key to get completion from OpenAI API. You can also set api_key in environment variable OPENAI_API_KEY or OPENAI_API_KEY_AZURE (if you want to use Azure OpenAI Service API).
    .PARAMETER engine
        The engine to get completion from OpenAI API. You can also set engine in environment variable OPENAI_ENGINE or OPENAI_ENGINE_AZURE (if you want to use Azure OpenAI Service API).
    .PARAMETER endpoint
        The endpoint to get completion from OpenAI API. You can also set endpoint in environment variable OPENAI_ENDPOINT or OPENAI_ENDPOINT_AZURE (if you want to use Azure OpenAI Service API).
    .PARAMETER max_tokens
        The max_tokens to get completion from OpenAI API. The default value is 1024.
    .PARAMETER temperature
        The temperature to get completion from OpenAI API. The default value is 1, which means most creatively.
    .PARAMETER n
        If you want to get multiple completion, you can use this parameter. The default value is 1.
    .PARAMETER azure
        If you want to use Azure OpenAI API, you can use this switch.
    .EXAMPLE
        New-OpenAICompletion -prompt "Which city is the capital of China?"
        Use default api_key, engine, endpoint from environment varaibles
    .EXAMPLE
        noc "Which city is the capital of China?"
        Use alias of the cmdlet with default api_key, engine, endpoint from environment varaibles
    .EXAMPLE
        "Which city is the capital of China?" | noc
        Use pipeline input
    .EXAMPLE
        noc "Which city is the capital of China?" -api_key "your api key"
        Set api_key in the command
    .EXAMPLE
        noc "Which city is the capital of China?" -api_key "your api key" -engine "davinci"
        Set api_key and engine in the command
    .EXAMPLE
        noc "Which city is the capital of China?" -azure
        Use Azure OpenAI API
    .EXAMPLE
        "string 1","string 2" | noc -azure
        Use Azure OpenAI API with pipeline input (multiple strings)
    .LINK
        https://github.com/chenxizhang/openai-powershell
    .INPUTS
        System.String, you can pass one or more string to the cmdlet, and we will get the completion for you.
    #>

    [CmdletBinding()]
    [Alias("noc")]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)][string]$prompt,
        [Parameter()][string]$api_key,
        [Parameter()][string]$engine,
        [Parameter()][string]$endpoint,
        [Parameter()][int]$max_tokens = 1024,
        [Parameter()][double]$temperature = 1,
        [Parameter()][int]$n = 1,
        [Parameter( ParameterSetName = “Azure”)][switch]$azure,
        [Parameter( ParameterSetName = “Azure”)][string]$environment
    )

    BEGIN {

        Write-Verbose "Parameter received. prompt: $prompt, api_key: $api_key, engine: $engine, endpoint: $endpoint, max_tokens: $max_tokens, temperature: $temperature, n: $n, azure: $azure"

        Write-Verbose "Environment variable detected. OPENAI_API_KEY: $env:OPENAI_API_KEY, OPENAI_API_KEY_AZURE: $env:OPENAI_API_KEY_AZURE, OPENAI_ENGINE: $env:OPENAI_ENGINE, OPENAI_ENGINE_AZURE: $env:OPENAI_ENGINE_AZURE, OPENAI_ENDPOINT: $env:OPENAI_ENDPOINT, OPENAI_ENDPOINT_AZURE: $env:OPENAI_ENDPOINT_AZURE"

        if ($azure) {
            $api_key = if ($api_key) { $api_key } else { Get-FirstNonNullItemInArray("OPENAI_API_KEY_AZURE_$environment", "OPENAI_API_KEY_AZURE") }
            $engine = if ($engine) { $engine } else { Get-FirstNonNullItemInArray("OPENAI_ENGINE_AZURE_$environment", "OPENAI_ENGINE_AZURE") }
            $endpoint = "{0}openai/deployments/{1}/completions?api-version=2022-12-01" -f $(if ($endpoint) { $endpoint }else { Get-FirstNonNullItemInArray("OPENAI_ENDPOINT_AZURE_$environment", "OPENAI_ENDPOINT_AZURE") }), $engine
        }
        else {
            $api_key = if ($api_key) { $api_key } else { $env:OPENAI_API_KEY }
            $engine = if ($engine) { $engine } else { if ($env:OPENAI_ENGINE) { $env:OPENAI_ENGINE }else { "text-davinci-003" } }
            $endpoint = if ($endpoint) { $endpoint } else { if ($env:OPENAI_ENDPOINT) { $env:OPENAI_ENDPOINT }else { "https://api.openai.com/v1/completions" } }
        }

        Write-Verbose "Parameter parsed, api_key: $api_key, engine: $engine, endpoint: $endpoint"

        $hasError = $false

        if ((!$azure) -and ((Test-OpenAIConnectivity) -eq $False)) {
            Write-Host $resources.openai_unavaliable -ForegroundColor Red
            $hasError = $true
        }


        if (!$api_key) {
            Write-Host $resources.error_missing_api_key -ForegroundColor Red
            $hasError = $true
        }

        if (!$engine) {
            Write-Host $resources.error_missing_engine -ForegroundColor Red
            $hasError = $true
        }

        if (!$endpoint) {
            Write-Host $resources.error_missing_endpoint -ForegroundColor Red
            $hasError = $true
        }

        if ($hasError) {
            return
        }
    }

    PROCESS {
    
        $params = @{
            Uri         = $endpoint
            Method      = "POST"
            Body        = @{
                model       = "$engine"
                prompt      = "$prompt"
                max_tokens  = $max_tokens
                temperature = $temperature
                n           = $n
            } | ConvertTo-Json -Depth 10
            Headers     = if ($azure) { @{"api-key" = "$api_key" } } else { @{"Authorization" = "Bearer $api_key" } }
            ContentType = "application/json;charset=utf-8"
        }

        Write-Verbose "Prepare the params for Invoke-WebRequest: $($params | ConvertTo-Json -Depth 10) "


        try {
            $response = Invoke-RestMethod @params

            Write-Verbose "Response received: $($response| ConvertTo-Json -Depth 10)"

            if ($PSVersionTable['PSVersion'].Major -eq 5) {
                Write-Verbose "Powershell 5.0 detected, convert the response to UTF8"

                $dstEncoding = [System.Text.Encoding]::GetEncoding('iso-8859-1')
                $srcEncoding = [System.Text.Encoding]::UTF8

                $response.choices | ForEach-Object {
                    $_.text = $srcEncoding.GetString([System.Text.Encoding]::Convert($srcEncoding, $dstEncoding, $srcEncoding.GetBytes($_.text)))
                }

                Write-Verbose "Response converted to UTF8: $($response | ConvertTo-Json -Depth 10)"
            }
        
            # parse the response to plain text
            $response = $response.choices.text
            Write-Verbose "Response parsed to plain text: $response"

            # write the response to console
            return $response
            # write the response to clipboard
            Set-Clipboard $response
            Write-Verbose "Response copied to clipboard: $response"
            
        }
        catch {
            Write-Host $_.ErrorDetails -ForegroundColor Red
        }
    }

}