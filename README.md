# notepad_pp_on_ChromeOS
Script for heavy lifting of installing Notepad++ using linux development environement on ChromeOS

# Notes
This bash script is designed with a special use case.  I have a computer lab that has been converted to ChromeOS using the [FlexOS](https://chromeenterprise.google/intl/en_uk/os/chromeosflex/) download and setup.  All of the needed tools for the lab are web based with the exception of notepad++. I know there are alternatives to notepad++ but the curriculumn being used was designed specifically for notepad++.  

# Setup
The following are the steps to get notepad++ on a ChromeOS environment that has Linux Development Environment enabled.

1. Go to ChromeOS settings, search for linux, then under the Linux Development Environment click the "Setup" button.  Follow the onscreen setup.
2. Once linux has been configured and installed run the following command:
    <br><code>wget https://raw.githubusercontent.com/jharttech/notepad_pp_on_ChromeOS/main/install.sh</code>
