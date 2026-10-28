****************
Packet Structure
****************


.. mermaid::
   
    --- 
    config:
      packet:
        showBits: true
        bitOrder: descending
    ---
    packet
    0-15: "Header"
    16-64: "Body"
    
Example
=======

Reference layout to follow, based on the IPv4 header: fixed-size fields
packed into 32-bit words, followed by the variable-size parts.

.. mermaid::

    packet
    title IPv4 Packet Structure
    0-3: "Version"
    4-7: "IHL"
    8-15: "Type of Service"
    16-31: "Total Length (bytes)"
    32-47: "Identification"
    48-50: "Flags"
    51-63: "Fragment Offset"
    64-71: "Time to Live"
    72-79: "Protocol"
    80-95: "Header Checksum"
    96-127: "Source Address"
    128-159: "Destination Address"
    160-191: "Options (if any)"
    192-223: "Payload"
