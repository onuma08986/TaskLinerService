if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

# Get current portforwarding numbers from environment variable
$ports = @([Environment]::GetEnvironmentVariable("PORT","User") -Split " ");

for( $i = 0; $i -lt $ports.length; $i++ ){
  $port = $ports[$i];
  iex "netsh interface portproxy delete v4tov4 listenport=$port";
  echo "closed Port:$port"
}

# Remove environment values is port number
[Environment]::SetEnvironmentVariable('PORT',"","User")

# Show proxies
iex "netsh interface portproxy show v4tov4";