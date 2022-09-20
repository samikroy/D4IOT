
function Get-D4IOTDeviceConnections {

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
        [int]$DeviceId,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int]$LastActiveInMinutes,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int]$DiscoveredBefore,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int]$DiscoveredAfter,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$IgnoreSSL
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Get-D4IOTDeviceConnections Method"

            try {

                Write-Verbose -Message "Parameters Formation Started...";
                
                $script:bodyContent = @{};
                
                GenerateRequestBody -AttributeName lastActiveInMinutes -AttributeValue $LastActiveInMinutes
                GenerateRequestBody -AttributeName discoveredBefore -AttributeValue $DiscoveredBefore
                GenerateRequestBody -AttributeName discoveredAfter -AttributeValue $DiscoveredAfter

                $BaseUri=[System.Uri]"https://$HostName//api//v1//devices//connections";

                if($DeviceId -gt 0)
                {
                    $BaseUri=[System.Uri]"https://$HostName//api//v1//devices//$DeviceId//connections";

                }
    
                $Paramhash = @{
                    Uri    = $BaseUri
                    Method  = 'GET'
                    Headers = @{Authorization = $APIKey}                
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
                Write-Error "Error in Get-D4IOTDeviceConnections $_.Exception.Message";
                return $_.Exception.Message ;
            }
    }
}
