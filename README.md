# hopensourcegateway

A demo of storing positions from your Husqvarna automower with gps.
View plots in Google maps via web server.
This demo has dependency to https://github.com/chrisz/pyhusmow.
See also requirements in pyhusmow repo.
To view an example, screendump here http://bredhammarconsulting.com/info/

# Scripts
## Prepare Linux environment
    sudo ./prepare-linux.sh

## Installing pyhusmow in virtualenv
    ./install-pyhusmow.sh

## Login
    ./login.sh
    
## Start recording plots
    ./store-am-positions.sh

## Start a web server to view plots
    ./start-web-server.sh
