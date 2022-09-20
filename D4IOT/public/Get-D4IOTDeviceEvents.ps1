
function Get-D4IOTDeviceEvents {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $HostName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$APIKey,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]$MinutesTimeFrame,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$EventType,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$IgnoreSSL
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Get-D4IOTDeviceEvents Method"

            try {
                Write-Verbose -Message "URI Formation Started..."
                $BaseUri=[System.Uri]"https://$HostName//api//v1//events";
                
                Write-Verbose -Message "Parameters Formation Started...";
                $script:bodyContent = @{};
                
                GenerateRequestBody -AttributeName minutesTimeFrame -AttributeValue $MinutesTimeFrame
                GenerateRequestBody -AttributeName type -AttributeValue $EventType
               
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
                Write-Error "Error in Get-D4IOTDeviceEvents $_.Exception.Message";
                return $_.Exception.Message ;
            }
    }
}
