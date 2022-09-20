
function Get-D4IOTDeviceCves {

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
        [bool]$IgnoreSSL,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [int]$Top,

        [Parameter(Mandatory = $false,
        ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$DeviceIP
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Get-D4IOTDeviceCves Method"

            try {

                Write-Verbose -Message "URI Formation Started..."
                $BaseUri=[System.Uri]"https://$HostName//api//v1//devices//cves";
                
                if($DeviceIP)
                {
                    Write-Verbose -Message "URI Formation Started for $DeviceIP"
                    $BaseUri=[System.Uri]"https://$HostName//api//v1//devices//$DeviceIP//cves";
                }
                
                Write-Verbose -Message "Parameters Formation Started...";
                
                $script:bodyContent = @{};
                
                GenerateRequestBody -AttributeName top -AttributeValue $Top

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
                Write-Error "Error in Get-D4IOTDeviceCves $_.Exception.Message";
                return $_.Exception.Message ;
            }
    }
}
