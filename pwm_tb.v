`timescale 1ns/1ps
`include "pwm.v"
module pwm_tb;

  // Testbench signals
  reg [7:0] duty_cycle;
  reg clk;
  reg reset;
  wire led;

  // Instantiate the PWM module
  pwm pwm_inst (
    .duty_cycle(duty_cycle),
    .clk(clk),
    .reset(reset),
    .led(led)
  );

  // Clock generation (50 MHz = 20ns period)
  always #10 clk = ~clk; // Toggle clock every 10ns -> 50 MHz clock

  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;

    // Apply reset
    #50 reset = 1;

    // Run simulation with different duty cycles
       duty_cycle = 8'd64;  // 25% duty cycle
     //duty_cycle = 8'd192; // 75% duty cycle
     //duty_cycle = 8'd255; // 100% duty cycle

    // End simulation after 800ns
    #10500 $finish;
  end

  // Enable waveform dump
  initial begin
    $dumpfile("pwm_wavedump.vcd");  // VCD file to store waveform data
    $dumpvars(0, pwm_tb);           // Dump all variables in the testbench
  end

endmodule
