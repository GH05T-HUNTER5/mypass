function Exit-OnSignal-SIGINT {
    Write-Host -NoNewline "`0"
    exit 0
}

function Exit-OnSignal-SIGTERM {
    Write-Host -NoNewline "`0"
    exit 0
}

trap { Exit-OnSignal-SIGINT } -Signal SIGINT
trap { Exit-OnSignal-SIGTERM } -Signal SIGTERM

function Random-Number {
    banner
    $fileName = Read-Host "[?] Output Filename : "
    if (-not $fileName) {
        Random-Number
    }

    def_users
    $number = 1
    while ($number -le $pass_lines) {
        $value = -join ((48..57) | Get-Random -Count $pass_length | ForEach-Object { [char]$_ })
        Write-Host "[Password]: $value [Saved]: $fileName"
        Add-Content -Path $fileName -Value $value
        $number++
    }

    Clear-Host
    Write-Host "[++] $fileName saved successfully"
    Start-Sleep -Seconds 3
    Clear-Host
    auto_password
}

function Random-Mix {
    banner
    $fileName = Read-Host "[?] Output Filename : "
    if (-not $fileName) {
        Random-Mix
    }

    def_users
    $number = 1
    while ($number -le $pass_lines) {
        $value = -join ((65..90) + (97..122) + (48..57) + 35, 64, 33, 47, 92, 93, 60, 62 | Get-Random -Count $pass_length | ForEach-Object { [char]$_ })
        Write-Host "[Password]: $value [Saved]: $fileName"
        Add-Content -Path $fileName -Value $value
        $number++
    }

    Clear-Host
    Write-Host "[++] $fileName saved successfully"
    Start-Sleep -Seconds 3
    Clear-Host
    auto_password
}

function Banner {
    Clear-Host
    Write-Host "+------------------------------------------------------+"
    Write-Host "| ██╗   ██╗██╗   ██╗██████╗  █████╗ ███████╗███████╗ |"
    Write-Host "| ███╗ ███║╚██╗ ██╔╝██╔══██╗██╔══██╗██╔════╝██╔════╝ |"
    Write-Host "| ██╔████╔██║ ╚████╔╝ ██████╔╝███████║███████╗███████╗ |"
    Write-Host "| ██║╚██╔╝██║  ╚██╔╝  ██╔═══╝ ██╔══██║╚════██║╚════██║ |"
    Write-Host "| ██║ ╚═╝ ██║   ██║   ██║     ██║  ██║███████║███████║ |"
    Write-Host "| ╚═╝     ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚══════╝ |"
    Write-Host "+-------------------- GH05T-HUNTER5 --------------------+"
    Write-Host "|         Easily create your own password list        |"
    Write-Host "+------------------------------------------------------+"
}

function Auto-Password {
    Banner
    Write-Host "[01] random letters"
    Write-Host "[02] random numbers"
    Write-Host "[03] random mix"
    Write-Host "[00] back"
    
    $option = Read-Host "[++] Select an option : "
    
    if (-not $option) {
        Auto-Password
    }
    elseif ($option -eq "01" -or $option -eq "1") {
        Random-Letters
    }
    elseif ($option -eq "02" -or $option -eq "2") {
        Random-Number
    }
    elseif ($option -eq "03" -or $option -eq "3") {
        Random-Mix
    }
    elseif ($option -eq "00" -or $option -eq "0") {
        Main-Menu
    }
    else {
        Auto-Password
    }
}

function Def-Users {
    $pass_lines = Read-Host "[++] how many lines : "
    if (-not $pass_lines) {
        Def-Users
    }

    $pass_length = Read-Host "[++] Minimum password length : "
    if (-not $pass_length) {
        Def-Users
    }
}

function Random-Letters {
    Banner
    $file_name = Read-Host "[?] Output Filename : "
    if (-not $file_name) {
        Random-Letters
    }

    Def-Users
    $number = 1
    while ($number -le $pass_lines) {
        $value = -join ((65..90) + (97..122) | Get-Random -Count $pass_length | ForEach-Object { [char]$_ })
        Write-Host "[Password]: $value [Saved]: $file_name"
        Add-Content -Path $file_name -Value $value
        $number++
    }

    Clear-Host
    Write-Host "[++] $file_name saved successfully"
    Start-Sleep -Seconds 3
    Clear-Host
    Auto-Password
}

function Manual-Password {
    Banner
    $file_name = Read-Host "[?] Output Filename : "
    if (-not $file_name) {
        Manual-Password
    }

    Def-Users
    Clear-Host
    Banner
    $number = 1
    while ($number -le $pass_lines) {
        $passwords = Read-Host "[++] Create your new password : "
        Add-Content -Path $file_name -Value $passwords
        $number++
    }

    Clear-Host
    Write-Host "[++] $file_name saved successfully"
    Start-Sleep -Seconds 3
    Clear-Host
    Main-Menu
}

function Main-Menu {
    Banner
    Write-Host "[01] Auto"
    Write-Host "[02] Manual"
    Write-Host "[99] Help"
    Write-Host "[00] Exit"

    $feedback = Read-Host "[++] Select an option : "
    if (-not $feedback) {
        Main-Menu
    }
    elseif ($feedback -eq "01" -or $feedback -eq "1") {
        Auto-Password
    }
    elseif ($feedback -eq "02" -or $feedback -eq "2") {
        Manual-Password
    }
    elseif ($feedback -eq "99") {
        Pass-Help
    }
    elseif ($feedback -eq "00") {
        Clear-Host
        exit
    }
    else {
        Main-Menu
    }
}

function MyPass-Help {
    Write-Host "Usage: mypass [options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "Auto"
    Write-Host "-l, --letter           password type (letter)"
    Write-Host "-n, --number           password type (number)"
    Write-Host "-m, --mix              password type (mixed password)"
    Write-Host "Use : mypass option 8 1000 filename"
    Write-Host "option  : -l, --letter, -n, --number , -m, --mix"
    Write-Host "8       : password length"
    Write-Host "1000    : password lines"
    Write-Host "filename: filename(password file name)"
    Write-Host "example"
    Write-Host "$ mypass -n 8 1000 password.txt"
    Write-Host "Manual"
    Write-Host "-manual, --manual, manual: create yourself (useful)"
    Write-Host "Use : mypass option 1000 filename"
    Write-Host "option  : -manual , --manual , manual"
    Write-Host "1000    : password length"
    Write-Host "filename: filename(password file name)"
    Write-Host "example"
    Write-Host "$ mypass manual 1000 password.txt"
    Write-Host "Or"
    Write-Host "Just Type : mypass"
    exit
}

function Auto-Random-Number {
    $number = 1
    while ($number -le $pass_lines) {
        $value = Get-Random -Minimum 0 -Maximum 10**$pass_length
        Add-Content -Path $file_name -Value $value
        $number++
    }
    Write-Host "[++] $file_name saved successfully"
}

function Auto-Random-Letters {
    $number = 1
    while ($number -le $pass_lines) {
        $value = -join ((65..90) + (97..122) | Get-Random -Count $pass_length | ForEach-Object { [char]$_ })
        Add-Content -Path $file_name -Value $value
        $number++
    }
    Write-Host "[++] $file_name saved successfully"
}

function Auto-Random-Mix {
    $number = 1
    while ($number -le $pass_lines) {
        $value = -join ((65..90) + (97..122) + (48..57) + 35, 64, 33, 47, 92, 93, 60, 62 | Get-Random -Count $pass_length | ForEach-Object { [char]$_ })
        Add-Content -Path $file_name -Value $value
        $number++
    }
    Write-Host "[++] $file_name saved successfully"
}

function Manual-Attackz {
    $number = 1
    while ($number -le $pass_lines) {
        $password4 = Read-Host "[++] Create your new password : "
        Add-Content -Path $file_name -Value $password4
        $number++
    }
    if (Test-Path $file_name) {
        Move-Item -Path $file_name -Destination ~ -Force
    }
    Write-Host "[++] $file_name saved successfully"
    Start-Sleep -Seconds 3
    exit
}

if (-not $args) {
    Main-Menu
}
elseif ($args[0] -eq "-l" -or $args[0] -eq "--letter") {
    if (-not $args[1]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_length = $args[1]
    }
    if (-not $args[2]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_lines = $args[2]
    }
    if (-not $args[3]) {
        Write-Host "Add filename"
        Start-Sleep -Seconds 2
        exit
    }
    else {
        $file_name = $args[3]
    }
    Auto-Random-Letters
}
elseif ($args[0] -eq "-n" -or $args[0] -eq "--number") {
    if (-not $args[1]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_length = $args[1]
    }
    if (-not $args[2]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_lines = $args[2]
    }
    if (-not $args[3]) {
        Write-Host "Add filename"
        Start-Sleep -Seconds 2
        exit
    }
    else {
        $file_name = $args[3]
    }
    Auto-Random-Number
}
elseif ($args[0] -eq "-m" -or $args[0] -eq "--mix") {
    if (-not $args[1]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_length = $args[1]
    }
    if (-not $args[2]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_lines = $args[2]
    }
    if (-not $args[3]) {
        Write-Host "Add filename"
        Start-Sleep -Seconds 2
        exit
    }
    else {
        $file_name = $args[3]
    }
    Auto-Random-Mix
}
elseif ($args[0] -eq "manual" -or $args[0] -eq "--manual" -or $args[0] -eq "-manual") {
    if (-not $args[1]) {
        Write-Host "Something Wrong"
        Start-Sleep -Seconds 2
        MyPass-Help
        exit
    }
    else {
        $pass_lines = $args[1]
    }
    if (-not $args[2]) {
        Write-Host "Add filename"
        Start-Sleep -Seconds 2
        exit
    }
    else {
        $file_name = $args[2]
    }
    Manual-Attackz
}
elseif ($args[0] -eq "-h" -or $args[0] -eq "--help") {
    MyPass-Help
}
else {
    MyPass-Help
}
