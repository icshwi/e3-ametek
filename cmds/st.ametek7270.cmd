require ametek,master
require stream,2.7.14p
require asyn,4.33.0+
require calc,3.7.1+
 
epicsEnvSet(EPICS_CA_MAX_ARRAY_BYTES,1000000)

epicsEnvSet("AMETEK_IP", "10.4.3.150")
epicsEnvSet("SYS", "LabS-Utgard-VIP:")
epicsEnvSet("DEV", "SES-AmpLI-1")

#Specify the TCP endpoint and give your 'bus' an arbitrary name eg. "ametek7270stream".
drvAsynIPPortConfigure("stream", "$(AMETEK_IP):50000")

# Stop readout at the first null byte. The device sends two extra
# bytes (status and overload) which will be flushed each time. 
asynOctetSetInputEos("stream", 0, "\0")

#asynSetTraceMask(  "stream", -1, 0x9)
#asynSetTraceIOMask("stream", -1, 0x2)
 
# Define the protocol path
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(ametek_DB)")

#Load the database defining the EPICS records
dbLoadRecords("ametek7270.db", "P=$(SYS), Q=$(DEV), PROTOCOL=ametekLockIn.proto, PORT=stream")
