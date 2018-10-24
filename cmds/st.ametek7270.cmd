epicsEnvSet(EPICS_CA_MAX_ARRAY_BYTES,1000000)

#Specify the TCP endpoint and give your 'bus' an arbitrary name eg. "ametek7270stream".
drvAsynIPPortConfigure("stream", "$(AMETEK_IP):50000")

# Stop readout at the first null byte. The device sends two extra
# bytes (status and overload) which will be flushed each time. 
asynOctetSetInputEos("stream", 0, "\0")

#asynSetTraceMask(  "stream", -1, 0x9)
#asynSetTraceIOMask("stream", -1, 0x2)
 
#Load your database defining the EPICS records
dbLoadRecords("ametek7270.template", "P=$(SYS), Q=$(DEV), PROTOCOL=ametekLockIn.proto, PORT=stream")
