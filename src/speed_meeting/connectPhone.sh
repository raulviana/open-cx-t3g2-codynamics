
#!/bin/bash

cd /home/$USER/Android/Sdk/platform-tools

./adb tcpip 5555

#After disconnect phone: adb connect <DECVICE_IP_ADRESS>:5555 to connect via wifi