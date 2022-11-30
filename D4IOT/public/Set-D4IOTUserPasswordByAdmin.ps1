
function Get-D4IOTSecurityVulnerabilities {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $AdminUserName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$AdminPassword,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$NewPassword,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$IgnoreSSL
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Set-D4IOTUserPasswordByAdmin Method"

            try {
                
                Write-Verbose -Message "Header Formation Started..."

                Write-Verbose -Message "URI Formation Started..."
                $BaseUri=[System.Uri]"https://$HostName//external//authentication//set_password_by_admin";

                
                Write-Verbose -Message "Parameters Formation Started...";
                
                $script:bodyContent = @{};
                
                GenerateRequestBody -AttributeName admin_username -AttributeValue $AdminUserName
                GenerateRequestBody -AttributeName admin_password -AttributeValue $AdminPassword
                GenerateRequestBody -AttributeName username -AttributeValue $UserName
                GenerateRequestBody -AttributeName new_password -AttributeValue $NewPassword

                $Paramhash = @{
                    Uri    = $BaseUri
                    Method  = 'POST'
                    Body    = $script:bodyContent                
                }
    
                if ($IgnoreSSL) {
                    $jsonresponse = Invoke-RestMethod @Paramhash -SkipCertificateCheck | ConvertTo-Json;
                    return $jsonresponse;
                }
                $jsonresponse = Invoke-RestMethod @Paramhash | ConvertTo-Json;
                return $jsonresponse;
            }
            catch {
                Write-Verbose "Exception Details"
                Write-Verbose $_;
                Write-Error "Error in Set-D4IOTUserPasswordByAdmin $_.Exception.Message";
                return $_.Exception.Message ;
            }
    }
}
