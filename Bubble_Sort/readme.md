Prompt

Design a module that implements the bubble sort algorithm within one cycle.  The module takes three inputs:  din, which corresponds to a BITWIDTH-bit unsigned word;  sortit, a 1-bit signal that is asserted in order to start a new sort operation;  and resetn, a synchronous, active-low reset signal.  The module's output is a (8*BITWIDTH+1)-bit unsigned bitstream that corresponds to a sorted vector of (8*BITWIDTH) unsigned words, which were stored in the module's memory when the input sortit is asserted. 

Input sortit is an asynchronous signal, coming from another module.  Assume there's no need to flop it.  Inputs are registered only when sortit = 0 and ignored otherwise.  Output dout is valid only when sortit = 1.  That is, the sorted vector is produced only when sortit = 1, or else dout is expected to produce zero.  The output vector is sorted in a descending order.  The BITWIDTH most significant bits correpond to the smallest value whereas the BITWIDTH least significant bits correspond to the largest value.
Input and Output Signals

    din - Unsigned data input word
    sortit - Sort input bit
    clk - Clock signal
    resetn - Synchronous, active low, reset signal
    dout - Output word corresponding to the sorted, concantenated memory-stored values when sortit is asserted

Output signals during reset

    dout - 0

Example

In the example, BITWIDTH = 3.  Initially, resetn is 0 and dout is reset.  The module's internal counter is also reset to zero.  After resetn is released, the module's internal counter starts.  In the subsequent cycles, din takes different values which are stored in the module's internal memory.  When sortit is asserted, the output dout = 000_001_010_011.  Note that, the most significant bits of dout correspond to the smallest value whereas the least significant bits of dout correspond to the largest value.
<img width="358" height="129" alt="Screenshot 2025-11-14 124432" src="https://github.com/user-attachments/assets/3ffdef61-c459-4601-843f-bbaa8cb9016c" />

