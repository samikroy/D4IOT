
function Get-D4IOTSecurityVulnerabilities {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $UserName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Password,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$IgnoreSSL
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Validate-D4IOTUserCredential Method"

            try {
                
                Write-Verbose -Message "Header Formation Started..."

                Write-Verbose -Message "URI Formation Started..."
                $BaseUri=[System.Uri]"https://$HostName//external//authentication//set_password";

                
                Write-Verbose -Message "Parameters Formation Started...";
                
                $script:bodyContent = @{};
                
                GenerateRequestBody -AttributeName username -AttributeValue $UserName
                GenerateRequestBody -AttributeName password -AttributeValue $Password

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
                Write-Error "Error in Validate-D4IOTUserCredential $_.Exception.Message";
                return $_.Exception.Message ;
            }
    }
}
