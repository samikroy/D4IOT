

function Get-D4IOTDeviceAlerts {

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
        [string]$AlertState,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]$AlertFromTime,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]$AlertToTime,
        
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$AlertType,

        [Parameter(Mandatory = $false,
            ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [switch]$IgnoreSSL
    )

    begin {
    }

    process {

        Write-Verbose -Message "Starting Get-D4IOTDeviceAlerts Method"

        try {
                
            Write-Verbose -Message "Parameters Formation Started...";

            $script:bodyContent = @{};

            GenerateRequestBody -AttributeName state -AttributeValue $AlertState
            GenerateRequestBody -AttributeName fromTime -AttributeValue $AlertFromTime
            GenerateRequestBody -AttributeName toTime -AttributeValue $AlertToTime
            GenerateRequestBody -AttributeName type -AttributeValue $AlertType

            $Paramhash = @{
                $Uri    = ([System.Uri]"https://$HostName//api//v1//alerts")
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
            Write-Error "Error in Get-D4IOTDeviceAlerts $_.Exception.Message";
            return $_.Exception.Message ;
        }
    }
}
