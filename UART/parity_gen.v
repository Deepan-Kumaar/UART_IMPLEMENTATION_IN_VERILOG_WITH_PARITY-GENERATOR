module PAR_GEN_CHK(
    input [7:0]in_DATA,
    output par_bit

);


xor(par_bit,in_DATA[0],in_DATA[1],in_DATA[2],in_DATA[3],in_DATA[4],in_DATA[5],in_DATA[6],in_DATA[7]);

/////NOTE:
/////This will generate and also will be used to check for a 1 for odd number of 1 logics and a zero for even number of 1 logics
/////This will be added for the error detection
/////Optional stuff not really required but i will do it anyways


endmodule