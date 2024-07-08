module UART_txrx_tb;
  //Ports
  reg [7:0] t_DATA;
  reg  trig_ss;
  wire [8:0] tx;//remeber that the input oonl y gets wires as inputs
  //reg  clk;

//wire []
  reg  [8:0]rx;
  reg  clk;
  reg [31:0] BAUD_RATE;
  wire ERROR;

  UART_tx  UART_tx_inst (
    .t_DATA(t_DATA),
    .trig_ss(trig_ss),
    .tx(tx),
    .clk(clk),
    .BAUD_RATE_TX(BAUD_RATE)
  );
  
 UART_rx  UART_rx_inst (
     .rx(tx),    
    .clk(clk),
    .BAUD_RATE_RX(BAUD_RATE),
    .ERROR(ERROR)
  );


initial assign rx=tx;
initial 
begin
    clk=0;///////DONT FORGET OR WONT WORK ALS=WAYS DO THISSS
    t_DATA=8'd10;//data to be transfered
    BAUD_RATE=32'd10;//rate
    
end

initial
begin
    #10;//////////this will start the stuff
    trig_ss=0;
    #10;
    trig_ss=1;

end

always #BAUD_RATE  clk = ! clk ;
always #100 $finish;
endmodule

 



