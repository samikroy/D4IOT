
function Get-D4IOTSecurityVulnerabilities {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $UserName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Password,

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

        Write-Verbose -Message "Starting Set-D4IOTUserPassword Method"

            try {
                
                Write-Verbose -Message "Header Formation Started..."

                Write-Verbose -Message "URI Formation Started..."
                $BaseUri=[System.Uri]"https://$HostName//external//authentication//set_password";

                
                Write-Verbose -Message "Parameters Formation Started...";
                
                $script:bodyContent = @{};
                
                GenerateRequestBody -AttributeName username -AttributeValue $UserName
                GenerateRequestBody -AttributeName password -AttributeValue $Password
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
                Write-Error "Error in Set-D4IOTUserPassword $_.Exception.Message";
                return $_.Exception.Message ;
            }
    }
}
