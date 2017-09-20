You can run this script on any machine with bash and jq (tested on OSX)

# Installing and running the script
Get a local copy of the script (you can rerun this to update the script to latest version in the future)
```
curl -s "https://raw.githubusercontent.com/AndrewSadler/tierion-tools/master/validate.sh" --output ./validate.sh
```
Give the script permission to be executes
```
chmod 755 ./validate.sh
```

Create a new file in the same directory as the script which is called `nodes.txt`. Each line in this file should be the wallet address used by one of your nodes, you can add as many nodes as you have, one per line.
e.g.
```
0x9Be97c6bec789C1033114fa2BF545aaE720f062D
0x9Be97c6bec789C1033114fa2BF545aaE720f062E
0x9Be97c6bec789C1033114fa2BF545aaE720f062F
0x9Be97c6bec789C1033114fa2BF545aaE720f0620
```
Save this file and you are then ready to run the tool.

# Install JQ tools
The script uses `jq` so this needs to be installed. You can find instructions for installation here [JQ Website](https://stedolan.github.io/jq/).

If you use OSX, then I would recommend installing [Homebrew](https://brew.sh/) and then doing:
``` 
brew install jq
```

# Run the tool to check your nodes
```
./validate.sh
```
You should see one line per address, with 'true' meaning the node is currently valid for rewards or 'false' meaning there is some issue that is invalidating the node.

# Investigate a failed node
```
curl -s curl -s https://b.chainpoint.org/nodes/<your failing node address> | jq
```
Should give you back a neatly formatted response of the most recent validity checks, the most recent is at the top. Look for any line with 'false', starting from the top - remember you need the top 4 results to only have 'true' for all lines!