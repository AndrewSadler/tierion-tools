#!/bin/bash

# MIT License

# Copyright (c) 2017 Andy Sadler

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


# Simple check to see if jq is installed
if ! [ -x "$(command -v "jq")" ]; then
  echo 'Error: jq is required and not installed see - https://stedolan.github.io/jq/' >&2
  exit 1
fi

# Add one new line in here for each node ETH address you want to validate. e.g.
# LIST=(
# '0x9Be97c6bec789C1033114fa2BF5450000000062D' \
# '0x9Be97c6bec789C1033114fa2BF54500000000001' \
# ...
# '0x9Be97c6bec789C1033114fa2BF5450000000000f' \
# ) 

LIST=(
'0x9Be97c6bec789C1033114fa2BF545aaE720f062D' \
)

function isNodeValid() {
    curl -s https://b.chainpoint.org/nodes/$1 | \
        jq '.recent_audits | .[0:4]' | \
        jq '[(.[] | { result: (.public_ip_test and .time_test and .calendar_state_test and .minimum_credits_test)})]' | \
        jq 'reduce .[].result as $item (true; . and $item)'
}

for i in "${LIST[@]}"
do
    echo $i - $(isNodeValid $i)
done