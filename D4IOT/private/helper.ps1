function GenerateRequestBody {
    Param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $AttributeName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        $AttributeValue
    )

    if ($AttributeValue -gt 0 -or $null -ne $AttributeValue) {
        $script:bodyContent.Add($AttributeName, $AttributeValue)
        Write-Verbose -Message "Parameter Added $AttributeName $AttributeValue"
    }
}
