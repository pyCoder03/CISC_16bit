# CISC_16bit
Modeling a 16-bit CISC processor "ZEAL" using Verilog to implement on FPGA.

### Bus Interface Unit

The Bus Interface Unit generates the control signals for Memory/IO read-write operations. This module receives microprocessor T-state count as input for synchronization. Moreover, synchronization is provided for signals such as ***DT/R’*** (Data Transfer or Receive) and Bus-Interface Enable. The Data strobe signals such as Read (***RD’***), Write (***WR’***) and Data Enable (***DEN’***) are generated using simple combinational logic. A small amount of behavioral modelling is also used.

A machine cycle consists of 4 T-states. The extra LSB in the T-state input is to enable the Bus-Interface signals to be controlled even at half T-states. In reality this three bits are generated by counting the processor at both the edges.

Regarding the signals, given the Bus-Interface Enable is high at the start of a machine cycle, a Write cycle is executed when DT/R’ is high, else a Read cycle. 

In a machine cycle, the following thins take place

- The ***ALE*** (Address Latch Enable) is made high for the first T-state alone, for the efficient demultiplexing of the address and data. The ALE will act as the strobe for an external latch which will then hold the address.
- The ***RD’*** or the ***WR’*** signals (depending on the ***DT/R’*** signal) are then made low for the next two T-states for giving sufficient time for the data to arrive at the data latches from the peripherals/reach the peripherals with stability. ***DEN’***(Data Enable) ******signal is also parallelly made low. Data Enable is used as a active-low output enable for the bidirectional (transceiver) buffer.
- After the ***************RD’*************** or the ***************WR’*************** signals are deactivated (made high), ***DEN’*** is deactivated after a half-T-state. This delay is to ensure that the bus is not closed (floated) before the data transmission is complete.

The generated RTL schematic for the Bus interface unit is,

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7d67ae72-1f9c-470d-abec-5db0ba95a1d5/Untitled.png)

Sample timing waveform

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a3df9231-01ec-4627-b52e-ce933ee97192/Untitled.png)

### Barrel Shifter

The Barrel Shifter is designed to perform all the shift-left operations using combinational style (edge triggered logic not used).

The ALU Shifter contains all the preprocessing and post processing logic to formulate all Shift left, right and all rotate operations.

Here comes the RTL schematic,

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c2e6a17f-220c-432f-ab64-7dfc05913a34/Untitled.png)
