Import-Module ActiveDirectory

Get-ADComputer -Filter * | ForEach {

    $cs = Get-WmiObject Win32_ComputerSystem -ComputerName $_.Name

    $os = Get-WmiObject Win32_OperatingSystem -ComputerName $_.Name

    $bios = Get-WmiObject Win32_BIOS -ComputerName $_.Name

    $props = @{
        'Machine Name' = $cs.Name
        'Manufacturer' = $cs.Manufacturer
        'Model' = $cs.Model
        'Operating System' = $os.Caption
        'Serial Number' = $bios.SerialNumber
    }

    New-Object PsObject -Property $props

} | Export-Csv .\machineAudit.csv -NoTypeInformation