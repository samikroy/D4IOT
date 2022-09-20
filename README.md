# Defender for IOT

| branch      | status |
| ----------- | -------|
| main      |    updated   |

Microsoft Defender for IoT is a unified security solution for identifying IoT and OT devices, vulnerabilities, and threats. With Defender for IoT, you can manage them through a central interface. This set of documentation describes how end-user organizations can secure their entire IoT/OT environment, including protecting existing devices or building security into new IoT innovations.

## Why this PowerShell Module

At this moment, there are API set available to get data out of Defender For IOT Sensosrs. Accessing & manageing the code to do so is likely to be a big task.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

* [PowerShell Core](https://github.com/PowerShell/PowerShell) >= 6.0

### Installing

You can install the latest version of D4IOT module from [PowerShell Gallery](https://www.powershellgallery.com/packages/D4IOT)

```PowerShell
Install-Module D4IOT -Scope CurrentUser -Force
```

### Usage

### PowerShell Commands

#### Get-D4IOTDevices

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|Authorized|bool|false|true, false|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

##### Response

```JSON
  [
    {
    "id": 1,
    "ipAddresses": [
      "172.28.48.1"
    ],
    "name": "BITC-SAMIKR-L",
    "vendor": "MICROSOFT CORPORATION",
    "operatingSystem": "Windows Server 2016",
    "macAddresses": [
      "00:15:5d:3d:ef:e8"
    ],
    "type": "DB Server",
    "engineeringStation": false,
    "authorized": true,
    "scanner": false,
    "protocols": [
      "@{id=1271525860; name=MDNS; addresses=System.Object[]}",
      "@{id=22; name=Netbios Datagram Service; addresses=System.Object[]}",
      "@{id=21; name=Netbios Name Service; addresses=System.Object[]}",
      "@{id=35; name=SMB; addresses=System.Object[]}"
    ],
    "firmware": null,
    "hasDynamicAddress": false
  }
]
```

#### Get-D4IOTDeviceConnections

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|DeviceId|int|false|*|
|LastActiveInMinutes|int|false|*|
|DiscoveredBefore|int|false|*|
|DiscoveredAfter|int|false|*|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

#### Get-D4IOTDeviceAlerts

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|AlertState|string|false|*|
|AlertFromTime|int|false|*|
|AlertToTime|int|false|*|
|AlertType|string|false|*|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

#### Get-D4IOTDeviceCves

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|Top|int|false|*|
|DeviceIP|string|false|*|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

#### Get-D4IOTDeviceEvents

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|EventType|string|true|*|
|MinutesTimeFrame|int|true|*|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

##### Response

```JSON
[
  {
    "title": "Device Connection Detected",
    "severity": "INFO",
    "type": "DEVICE_CONNECTION_CREATED",
    "owner": null,
    "timestamp": 1660313625000,
    "content": "Connected devices 172.25.96.1 and 255.255.255.255"
  }
] 
```

#### Get-D4IOTDeviceVulnerabilities

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

#### Get-D4IOTOperationalVulnerabilities

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

#### Get-D4IOTDeviceVulnerabilities

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|

#### Get-D4IOTSecurityVulnerabilities

The following tables describe the values you need to set as parameter

| Name | Type | Required | Allowed Values |
|----- | ---- | -------- | ---------------|
|IgnoreSSL|bool|false|true, false|
|HostName|string|true|*|
|APIKey|string|true|*|


## Find us

* [GitHub](https://github.com/samikroy/)
* [PowerShell Gallery](https://www.powershellgallery.com/packages/D4IOT/)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Author / Contributor


## Authors

* **Samik Roy** - *Developer and Maintainer* - [GitHub](https://github.com/samikroy/)

## Versioning

We use [GitHub](https://github.com/) for versioning.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Many thanks to anyone whose code was used!
