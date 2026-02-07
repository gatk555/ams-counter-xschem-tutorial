`timescale 1ns/1ns

// Optional pure-digital testbench for the counter.
// This is NOT required for the Ngspice d_cosim flow.
// It is only here to validate the Verilog block in isolation.

module tb_counter;

  reg clk;
  wire [3:0] count;

  counter dut (
    .clk(clk),
    .count(count)
  );

  initial begin
    clk = 0;
    repeat (20) begin
      #5 clk = ~clk;
    end
    $display("final count=%0d", count);
    $finish;
  end

endmodule
