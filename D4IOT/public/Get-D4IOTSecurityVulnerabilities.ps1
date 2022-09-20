
function Get-D4IOTSecurityVulnerabilities {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$APIKey,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$IgnoreSSL
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Get-D4IOTSecurityVulnerabilities Method"

            try {
                
                Write-Verbose -Message "Header Formation Started..."

                Write-Verbose -Message "URI Formation Started..."
                $BaseUri=[System.Uri]"https://$HostName//api//v1//reports//vulnerabilities//security";


                $Paramhash = @{
                    Uri    = $BaseUri
                    Method  = 'GET'
                    Headers = @{Authorization = $APIKey}                
                }
    
                if ($IgnoreSSL) {
                    $jsonresponse = Invoke-RestMethod @Paramhash -SkipCertificateCheck | ConvertTo-Json;
                    return $jsonresponse;
                }
                $jsonresponse = Invoke-RestMethod @Paramhash | ConvertTo-Json;
                return $jsonresponse;
            }
            catch {
                $return = $_.Exception.Message;
                Write-Verbose $_;
                Write-Error "Error in Get-D4IOTSecurityVulnerabilities $return";
                return $return ;
            }
    }
}
