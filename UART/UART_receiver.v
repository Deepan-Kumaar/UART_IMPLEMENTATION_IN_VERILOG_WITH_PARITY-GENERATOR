`include "parity_gen.v"
module UART_rx (
    input [8:0]rx,
    input clk,
    input [31:0] BAUD_RATE_RX,
    output reg ERROR 
);

reg[2:0] state;
parameter [2:0] IDLE =3'd0 ;
parameter [2:0] ERROR_CHECK =3'd1 ;//state to check the error using parity checker
parameter [2:0] RECEIVE =3'd2 ;
parameter [2:0] STOP =3'd3 ;

//parity checker
wire par_cbit;///dont know if it will work check this<<<DIDNT WORK to changed from reg to wire


//integer i;
reg [7:0] mem ;
reg [8:0] temp;

initial
begin
state=IDLE;
ERROR =0;
end

always
begin
case (state)
IDLE:
begin
    @(negedge rx) #(2*BAUD_RATE_RX) state=RECEIVE;
    
end
RECEIVE:
begin 
    #5;
    temp<=rx;
    mem<=rx[8:1];   
    #10;
    ////NOTE:
    ///////you need to make the value of mem get only read in this state and not get mem as 01<<<<DONE
    ///////get read before going to another state and only here<<<DONE
    ///////try baud to get buad rate<<<<Done
    ///////also get the parity checker done too......optional<<<<almosy done did the parity gen now have to add
    ///////mostly no change in the tb but check at last only if nothing is done<<<<YES WAS THE PROB
    state=STOP;
end

STOP:
begin
    @(posedge rx)state=IDLE;
    ERROR=0;
    
end

endcase
end

///check the parity bit
PAR_GEN_CHK chk(temp[8:1],par_cbit);
always@(*)
begin
    if(par_cbit!=temp[0])
    begin
        ERROR=1;        
    end
 end

endmodule //UART_receiver