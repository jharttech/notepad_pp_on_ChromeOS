# notepad_pp_on_ChromeOS
Script for heavy lifting of installing Notepad++ using linux development environement on ChromeOS

# Notes
This bash script is designed with a special use case.  I have a computer lab that has been converted to ChromeOS using the [FlexOS](https://chromeenterprise.google/intl/en_uk/os/chromeosflex/) download and setup.  All of the needed tools for the lab are web based with the exception of notepad++. I know there are alternatives to notepad++ but the curriculumn being used was designed specifically for notepad++.
This script installs the snap version of notepad++ as it has the needed wine packages and configurations packaged.  

# Setup
The following are the steps to get notepad++ on a ChromeOS environment that has Linux Development Environment enabled.

1. Go to ChromeOS settings, search for linux, then under the Linux Development Environment click the "Setup" button.  Follow the onscreen setup.
2. Use the ChromeOS app drawer to search for "Terminal" and launch it.  Click on "penquin" to launch your linux terminal.
3. Once linux has been configured and installed, type the following command and press enter to download the install script:
    <br><code>wget https://raw.githubusercontent.com/jharttech/notepad_pp_on_ChromeOS/main/install.sh</code><br>
4. Now that the install.sh script has been downloaded onto ChromeOS, you will need to open the Files application on ChromeOS and move the install.sh file from Downloads to Linux Files.
5. Type the following command in the terminal and press enter to make sure the install.sh file exists in your linux home directory.  If it does not exist then something in the steps above has gone wrong.
    <br><code>ls</code><br>
6. Now make the install.sh file executable by typing the following command and pressing enter:
    <br><code>chmod +x install.sh</code><br>
7. Run the install script by typing the command below and pressing enter:
    <br><code>./install.sh</code><br>
8. If the install script completed without issue then notepad++ should now be listed in the ChromeOS app drawer under the linux apps area.

Feel free to adjust the install script to meet your own needs, the line that executes the "xhost +" command in particular as this is generic for this project and can be a security risk.
