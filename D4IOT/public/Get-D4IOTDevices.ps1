
function Get-D4IOTDevices {

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
        [bool]$Authorized,

        [Parameter(Mandatory = $false,
            ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [bool]$IgnoreSSL
    )

    begin {
        #precheck
    }

    process {

        Write-Verbose -Message "Starting Get-D4IOTDevices Method"

            try {

                Write-Verbose -Message "Header Formation Started..."

                $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
                $headers.Add("Authorization", "$APIKey")

                Write-Verbose -Message "$APIKey"
                Write-Verbose -Message "$HostName"

                
                Write-Verbose -Message "URI Formation Started...";
                $strUri = "https://$HostName//api//v1//devices";
                
                Write-Verbose -Message "Parameters Formation Started...";
                
                $BaseUri=[System.Uri]$strUri;

                $script:bodyContent = @{};

                GenerateRequestBody -AttributeName authorized -AttributeValue $authorized
                Write-Verbose "Body Generated"
                Write-Verbose $script:bodyContent
                $Paramhash = @{
                    Uri    = $BaseUri
                    Method  = 'GET'
                    Headers = @{Authorization = $APIKey}                
                    Body    = $script:bodyContent
                }
                Write-Verbose $script:bodyContent
                Write-Verbose $IgnoreSSL

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
                Write-Error "Error in Get-D4IOTDevices $return";
                return $return ;
            }
    }
}
