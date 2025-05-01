//-----------------------------------------------------------------------------
// File: tb_knn_top_debug.v
//-----------------------------------------------------------------------------
// Testbench with hierarchical debug prints of internal state & counters
//-----------------------------------------------------------------------------

`timescale 1ns/1ps

module test_bench;
  // parameters must match top
  localparam TRAIN_SIZE    = 150,
             FEATURE_COUNT =   4,
             DATA_WIDTH    =  16,
             LABEL_WIDTH   =   8;
				 
	localparam TEST_INDEX = 120;

  // DUT I/O
  reg  clk, rst;
  reg  [FEATURE_COUNT*DATA_WIDTH-1:0] test_sample_flat;
  wire [LABEL_WIDTH-1:0]              predicted_class;
  wire                                done;

  // instantiate your top-level (make sure this is named "top" in top.v)
  top #(
    .TRAIN_SIZE    (TRAIN_SIZE),
    .FEATURE_COUNT (FEATURE_COUNT),
    .DATA_WIDTH    (DATA_WIDTH),
    .LABEL_WIDTH   (LABEL_WIDTH)
  ) dut (
    .clk              (clk),
    .rst              (rst),
    .test_sample_flat (test_sample_flat),
    .predicted_class  (predicted_class),
    .done             (done)
  );

  // local copy of the Iris memory
  reg signed [DATA_WIDTH-1:0]
      tb_train_data_mem [0:TRAIN_SIZE*FEATURE_COUNT-1];
  reg [LABEL_WIDTH-1:0]
      tb_train_label_mem[0:TRAIN_SIZE-1];

  initial begin
    $readmemh("train_data.hex",  tb_train_data_mem);
    $readmemh("train_labels.hex",tb_train_label_mem);
  end

  // dump waves (if you want)
  initial begin
    $dumpfile("tb_knn_top_debug.vcd");
    $dumpvars(0, test_bench);
  end

  // 10 ns clock
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // apply reset & stimulus
  initial begin
    rst = 1;
    test_sample_flat = 0;
    #20;
    rst = 0;
    #10;
    // feed sample[0]
    // feed sample[TEST_INDEX]
    test_sample_flat = {
      // row-major: sample*FEATURE_COUNT + (FEATURE_COUNT-1 downto 0)
      tb_train_data_mem[ TEST_INDEX*FEATURE_COUNT + 3 ],
      tb_train_data_mem[ TEST_INDEX*FEATURE_COUNT + 2 ],
      tb_train_data_mem[ TEST_INDEX*FEATURE_COUNT + 1 ],
      tb_train_data_mem[ TEST_INDEX*FEATURE_COUNT + 0 ]
    };
  end

  // timeout so sim won’t hang forever
  //initial begin
    //#20000;
    //$display("ERROR: TIMEOUT at %0t — done never asserted", $time);
    //$finish;
  //end

  // on every clock edge, print:
  //  • dut.ctrl.state      — your controller’s state register
  //  • dut.dp.i            — the outer-loop counter
  //  • dut.dp.j            — the inner-loop counter
  //  • the comparators
  //  • done and predicted_class
  // monitor EVERY clock: show state, i, j, distance, min_distance, comparators, done, pred
  always @(posedge clk) begin
    $display(
      "T=%0t rst=%b  state=%0d  i=%0d  j=%0d  dist=%0d  min=%0d  i<TRAIN=%b  j<FEAT=%b  dist<min=%b  done=%b  pred=%0d",
       $time,
       rst,
       dut.ctrl.state,        // controller’s state reg
       dut.dp.i,              // full-width outer counter
       dut.dp.j,              // full-width inner counter
       dut.dp.distance,       // accumulator
       dut.dp.min_distance,   // best-so-far
       dut.i_lt_train,
       dut.j_lt_feat,
       dut.dist_lt_min,
       done,
       predicted_class
    );
  end


  // once done goes high, check pass/fail and finish
  always @(posedge done) begin
    if (predicted_class === tb_train_label_mem[TEST_INDEX])
      $display(">>> PASS at %0t: predicted=%0d matches expected=%0d",
               $time, predicted_class, tb_train_label_mem[TEST_INDEX]);
    else
      $display(">>> FAIL at %0t: predicted=%0d expected=%0d",
               $time, predicted_class, tb_train_label_mem[TEST_INDEX]);
    $finish;
  end

endmodule
