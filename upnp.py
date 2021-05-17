import miniupnpc

upnp = miniupnpc.UPnP()

upnp.discoverdelay = 200
ndevices = upnp.discover()
print(ndevices, "device(s) detected")

upnp.selectigd()
print("local ip address: ", upnp.lanaddr)
print(upnp.statusinfo(), upnp.connectiontype())

port=54321

upnp.addportmapping(port, "TCP", upnp.lanaddr, port, "testing", "")
