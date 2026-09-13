$ROOT = "."

# Reports folder
if (!(Test-Path "reports")) {
    New-Item -ItemType Directory -Path "reports" | Out-Null
}

function Run-Tool {
    param(
        [string]$Name,
        [scriptblock]$Command
    )

    Write-Host ""
    Write-Host "===================================="
    Write-Host "Running $Name"
    Write-Host "===================================="

    try {
        & $Command

        if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq $null) {
            Write-Host "$Name Completed"
        }
        else {
            Write-Host "$Name Finished with Exit Code $LASTEXITCODE"
        }
    }
    catch {
        Write-Host "$Name Failed"
        Write-Host $_.Exception.Message
    }
}

# Terraform
Run-Tool "Terraform Init" {
    terraform init -backend=false -input=false
}

Run-Tool "Terraform Validate" {
    terraform validate | Out-File reports\terraform_validate.txt
}

Run-Tool "Terraform Format" {
    terraform fmt -check -recursive | Out-File reports\terraform_fmt.txt
}

# TFLint
Run-Tool "TFLint Init" {
    tflint --init
}

Run-Tool "TFLint" {
    tflint --format json | Out-File reports\tflint.json
}

# Checkov
Run-Tool "Checkov" {
    checkov -d $ROOT -o json | Out-File reports\checkov.json
}

# tfsec
Run-Tool "tfsec" {
    tfsec $ROOT --format json --out reports\tfsec
}

# Terrascan
Run-Tool "Terrascan" {
    terrascan scan -d $ROOT -o json | Out-File reports\terrascan.json
}

# Semgrep
Run-Tool "Semgrep" {
    semgrep scan `
        --config auto `
        --exclude reports `
        --exclude .terraform `
        --json `
        --output reports\semgrep.json `
        $ROOT
}

# Gitleaks
Run-Tool "Gitleaks" {
    gitleaks detect `
        --source $ROOT `
        --report-format json `
        --report-path reports\gitleaks.json
}

# TruffleHog
Run-Tool "TruffleHog" {
    trufflehog filesystem $ROOT --json | Out-File reports\trufflehog.json
}

# Infracost
Run-Tool "Infracost" {
    infracost scan `
        --path $ROOT `
        --format json `
        --out-file reports\infracost.json
}

Write-Host ""
Write-Host "===================================="
Write-Host "Scanning Completed"
Write-Host "Reports saved in reports folder"
Write-Host "===================================="