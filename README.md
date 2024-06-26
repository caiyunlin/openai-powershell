[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/code365scripts.openai?label=code365scripts.openai)](https://www.powershellgallery.com/packages/code365scripts.openai) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/code365scripts.openai)](https://www.powershellgallery.com/packages/code365scripts.openai) [![](https://img.shields.io/badge/change-logs-blue)](CHANGELOG.md) [![](https://img.shields.io/badge/lang-简体中文-blue)](README.zh.md) [![](https://img.shields.io/badge/user_manual-English-blue)](https://github.com/chenxizhang/openai-powershell/discussions/categories/use-cases)

This is an unofficial OpenAI PowerShell module that allows you to get text completion or start a chat experience or generate image directly in PowerShell. You can use OpenAI Service, Azure OpenAI Service and almost all the GPT services and even the local LLMs in a consistent way, You can easily automate those batch processing tasks, scheduled tasks, and heavy manual tasks in one or two lines of commands.

This module is compatible with PowerShell 5.1 and above, and if you are using PowerShell Core (6.x+), it can be used on all platforms including Windows, MacOS, and Linux.

## Prerequisites

To use this module, you must install PowerShell. It is included by default in Windows. If you are using MacOS or Linux, you can install it using the following guide:

- MacOS:
  - Run `brew install powershell/tap/powershell` to install PowerShell on MacOS, then enter `pwsh` in the terminal to launch PowerShell. Follow the guide [here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos) if you encountered any problem.
- Linux:
  - Follow the guide [here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux?view=powershell-7.3) to install PowerShell on Linux, then enter `pwsh` in the terminal to launch PowerShell.

You will also need to prepare your API key, which is essential before using the module. A basic understanding of LLM models is also necessary. Most OpenAI services, Azure OpenAI services, and many services similar to OpenAI require a subscription and are not free. The good news is we also support local LLM if you have a powerful GPU machine, which can offer additional functionality.

## Install the Module

To install the module, run the following command in PowerShell:

```powershell
Install-Module -Name code365scripts.openai -Scope CurrentUser
```

You might want to run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` if you get an error when you run the `Install-Module` cmdlet.

## Quick Start

1. [Start a chat experience on your desktop](https://github.com/chenxizhang/openai-powershell/discussions/192) with the `chat` command, please make sure you set the environment variable `OPENAI_API_KEY` to your API key before running the command. If you are using **Azure OpenAI service** or other platform or LLMs rather than **OpenAI service**, you might want to set `OPENAI_API_ENDPOINT` and `OPENAI_API_MODEL` variables. It supports `OpenAI`, `Azure OpenAI`, `Databricks`, `KIMI`, `Zhipu Qingyan`, and a large number of open-source models run by `ollama` (such as llama3, etc.) and any other platforms and large models compatible with OpenAI services.

    ![GIF 5-5-2024 10-49-20 PM](https://github.com/chenxizhang/openai-powershell/assets/1996954/eb5629f8-7014-4b0b-84e5-82259265ab07)

1. Get text completions by using `gpt` command. You can generate any text based on your own prompt in a single line of command. 

    ![image](https://github.com/chenxizhang/openai-powershell/assets/1996954/f4a21c9d-93c6-4944-9936-ae3718d40857)

   Imagine you need to classify the customer feedback by using GPT technology, then you write back the result in the CSV file. You can achieve the goal with just a single line of code as below.

   ```powershell
   Import-Csv surveyresult.csv `
     | Select-Object Eamil,Feedback, `
       @{l="Category";e={gpt -system classifyprompt.md -prompt $_.Feedback}} `
     | Export-Csv surveyresult.csv
   ```

1. Generate images by using the `image` command. It supports the Azure OpenAI service, OpenAI service, currently using the `DALL-E-3` model.

    <img width="956" alt="image" src="https://github.com/chenxizhang/openai-powershell/assets/1996954/cdad0352-9a8a-4d8f-bacd-ff8dd989a4bb">

## User Manual in details

1. [Start your desktop ChatGPT journey with a simple command](https://github.com/chenxizhang/openai-powershell/discussions/192)
2. [Three basic parameters adapted to major platforms and models](https://github.com/chenxizhang/openai-powershell/discussions/193)
3. [Get Help](https://github.com/chenxizhang/openai-powershell/discussions/194)
4. [Aliases for commands and parameters](https://github.com/chenxizhang/openai-powershell/discussions/195)
5. [System and user prompts](https://github.com/chenxizhang/openai-powershell/discussions/196)
6. [Customizing Settings](https://github.com/chenxizhang/openai-powershell/discussions/198)
7. [Dynamically passing context data](https://github.com/chenxizhang/openai-powershell/discussions/199)
8. [Function calls](https://github.com/chenxizhang/openai-powershell/discussions/200)
9. [What are the limitations of PowerShell 5.1 version?](https://github.com/chenxizhang/openai-powershell/discussions/201)
10. [Using DALL-E-3 to generate images](https://github.com/chenxizhang/openai-powershell/discussions/202)
11. [Using local models](https://github.com/chenxizhang/openai-powershell/discussions/203)
12. [Use environment variables](https://github.com/chenxizhang/openai-powershell/discussions/204)
13. [Use AAD authentication](https://github.com/chenxizhang/openai-powershell/discussions/244)
14. [Use in Github Action](https://github.com/chenxizhang/openai-powershell/discussions/247)

## Telemetry Data Collection and Privacy

We collect telemetry data to help improve the module. The collected data includes `command name`, `alias`, `service provider`, `module version`, and `PowerShell version`. You can view the source code [here](https://github.com/chenxizhang/openai-powershell/blob/master/code365scripts.openai/Private/Submit-Telemetry.ps1). **No personal or input data is collected.** If you do not wish to send telemetry data, you can set the environment variable `DISABLE_TELEMETRY_OPENAI_POWERSHELL` to `true`.

## Update the Module

To update the module, run the following command in PowerShell:

```powershell
Update-Module -Name code365scripts.openai
```

## Uninstall the Module

To uninstall the module, run the following command in PowerShell:

```powershell
Uninstall-Module -Name code365scripts.openai
```
