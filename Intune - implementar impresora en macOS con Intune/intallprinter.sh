#!/bin/bash

# Nombre del puerto la impresora sudo lpadmin -p CHANGE_ME_NAME
# IP de la impresora ipp:/CHANGCHANGE_ME_IP/ipp/print
# Nombre a msotrar -D "CHANGE_ME_NAME"

#IMPRESORA 1
sudo lpadmin -p CHANGE_ME_NAME -E -v ipp:/CHANGCHANGE_ME_IP/ipp/print -m everywhere -D "CHANGE_ME_NAME"

#IMPRESORA 2
sudo lpadmin -p CHANGE_ME_NAME -E -v ipp://CHACHANGE_ME_IP/ipp/print -m everywhere -D "CHANGE_ME_NAME"

#IMPRESORA 3
sudo lpadmin -p CHANGE_ME_NAME -E -v ipp://CHANGE_ME_IP/ipp/print -m everywhere -D "CHANGE_ME_NAME"