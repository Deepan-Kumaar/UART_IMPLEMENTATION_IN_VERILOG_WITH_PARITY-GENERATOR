`include "parity_gen.v"//parity generator for the transmitter to check for errors

module UART_tx (
    input  [8:0] t_DATA,
    input  trig_ss,
    output  reg [8:0]tx,
    input clk,
    input [31:0] BAUD_RATE_TX

);
//this is the register that will trigger the start or stop this is triggered by the input trig_ss
reg ss=1;

//state for the fsm
reg [2:0] state;
parameter [2:0] IDLE =3'd0 ;
parameter [2:0] START =3'd1 ;
parameter [2:0] SEND =3'd2 ;
parameter [2:0] STOP =3'd3 ;

initial state<=IDLE;



//memory registers
reg [8:0] smem;
reg [8:0] rmem;
wire par_bit;
reg bit;
//save DATA to mem

PAR_GEN_CHK par_gen(t_DATA,par_bit);
//initial bit=par_bit;


always @(*) 
begin
    smem={t_DATA,par_bit};
    
end

//parity gen



////NOTE:STOPPED HERE 
////ADDED PAR GEN to the code need to wire it up 
/////CHANGED THE VALUES OF REGISTERS AND THE INPUTS TO 9 BITS INSTEAD OF 8 BITS

//this is the register that will trigger the start or stop this is triggered by the input trig_ss
always@(*)
begin
ss=(trig_ss==1)?0:1;

end

always@(posedge clk)
begin
case(state)
    IDLE:
    begin
        tx=1;
        @(negedge ss) state=START;        

    end
    START:
    begin
        tx=0;
        state=SEND;
        //also try to make a parity checker is send a error message to again make the transmission happen correctly<<<<<<DONE
        //also baud rate to send the data in a particular rate<<<<<<DONE
    end
    SEND:
    begin
        assign tx=smem;
        state=STOP;        
    end
    STOP:
    begin
        assign tx=0;
        #BAUD_RATE_TX;
        assign tx=1;
        ss=1;        
        state=IDLE;
    end
endcase 
end          

endmodule //UART_transmitter