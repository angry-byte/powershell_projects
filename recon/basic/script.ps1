$file_name = Read-Host -Prompt "Enter the file name to be created to write the output: "

echo "========================" >> $file_name
echo "Basics Information" >> $file_name
echo "========================" >> $file_name

echo "systeminfo output:" >> $file_name
systeminfo >> $file_name
echo "" >> $file_name

echo "Information on Powershell: " >> $file_name
$PSVersionTable >> $file_name
echo "" >> $file_name

echo "========================" >> $file_name
echo "Groups and Users" >> $file_name
echo "========================" >> $file_name

echo "All Users on this System:" >> $file_name
Get-ChildItem C:\Users -Force | select Name >> $file_name
echo "" >> $file_name

echo "All Groups:" >> $file_name
Get-LocalGroup | ft Name >> $file_Name
echo "" >> $file_name

echo "========================" >> $file_name
echo "Networking Information" >> $file_name
echo "========================" >> $file_name

echo "Network Interfaces: ">> $file_name
ipconfig /all >> $file_name
echo "" >> $file_name

echo "Hosts File Contents:" >> $file_name
Get-Content C:\WINDOWS\System32\drivers\etc\hosts >> $file_name
echo "" >> $file_name

netsh firewall show state >> $file_name
echo "" >> $file_name

echo "========================" >> $file_name
echo "Services and Processes" >> $file_name
echo "========================" >> $file_name

echo "Processes Running:" >> $file_name
Get-Process | where {$_.ProcessName -notlike "svchost*"} | ft ProcessName, Id >> $file_name
echo "" >> $file_name

echo "Services Running:" >> $file_name
Get-Service >> $file_name

echo "Scheduled Tasks:" >> $file_name
Get-ScheduledTask | where {$_.TaskPath -notlike "\Microsoft*"} | ft TaskName,TaskPath,State >> $file_name
echo "" >> $file_name

echo "========================" >> $file_name
echo "Security Information" >> $file_name
echo "========================" >> $file_name

echo "Antivirus Status:" >> $file_name
Get-MpComputerStatus >> $file_name

echo "Password Policy:" >> $file_name
net accounts >> $file_name

echo "List of nstalled updates:" >> $file_name
Get-Hotfix | Sort InstalledOn >> $file_name


echo "========================" >> $file_name
echo "List of Installed Software" >> $file_name
echo "========================" >> $file_name

$INSTALLED = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
$INSTALLED += Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
$INSTALLED | ?{ $_.DisplayName -ne $null } | sort-object -Property DisplayName -Unique | Format-Table -AutoSize >> $file_name


