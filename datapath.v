module datapath #(
  parameter TRAIN_SIZE     = 150,
  parameter FEATURE_COUNT  =   4,
  parameter DATA_WIDTH     =  16,
  parameter LABEL_WIDTH    =   8
)(
  input  wire                   clk,
  input  wire                   rst,
  input  wire                   i_load,
  input  wire                   i_inc,
  input  wire                   j_load,
  input  wire                   j_inc,
  input  wire                   dist_load,
  input  wire                   dist_acc,
  input  wire                   min_load,
  input  wire                   pred_load,
  input  wire [FEATURE_COUNT*DATA_WIDTH-1:0] test_sample_flat,
  output wire                   i_lt_train,
  output wire                   j_lt_feat,
  output wire                   dist_lt_min,
  output wire [LABEL_WIDTH-1:0] predicted_class_out,
  output wire [$clog2(FEATURE_COUNT)-1:0]  j_out
);

  // widths
  localparam IDX_I_WIDTH = $clog2(TRAIN_SIZE),
             IDX_J_WIDTH = $clog2(FEATURE_COUNT),
             DIST_WIDTH  = 2*DATA_WIDTH + $clog2(FEATURE_COUNT);

  // loop counters, accumulators
  reg [IDX_I_WIDTH-1:0]       i;
  reg [IDX_J_WIDTH:0]       j;
  reg signed [DIST_WIDTH-1:0] distance, min_distance;
  reg [LABEL_WIDTH-1:0]       predicted_class;
  assign j_out = j;
  // “infinite” seed
    localparam signed [DIST_WIDTH-1:0] MAX_DISTANCE = {1'b0, {(DIST_WIDTH-1){1'b1}}};

  // flat memories
  localparam MEM_FEATURE_DEPTH = TRAIN_SIZE*FEATURE_COUNT,
             ADDR_FEATURE_W   = $clog2(MEM_FEATURE_DEPTH);
  reg signed [DATA_WIDTH-1:0]   train_data_mem  [0:MEM_FEATURE_DEPTH-1];
  reg       [LABEL_WIDTH-1:0]   train_label_mem [0:TRAIN_SIZE-1];

  initial begin
    $readmemh("train_data.hex",  train_data_mem);
    $readmemh("train_labels.hex",train_label_mem);
  end

  // addresses & reads
  wire [ADDR_FEATURE_W-1:0]        feature_addr    = i * FEATURE_COUNT + j;
  wire signed [DATA_WIDTH-1:0]     current_feature = train_data_mem[feature_addr];
  wire [LABEL_WIDTH-1:0]           current_label   = train_label_mem[i];

  // unpacked test_sample[j]
  wire signed [DATA_WIDTH-1:0]     test_sample_j   = 
      test_sample_flat[j*DATA_WIDTH +: DATA_WIDTH];

  // combinational diff & square
  wire signed [DATA_WIDTH-1:0]     d  = test_sample_j - current_feature;
  wire signed [2*DATA_WIDTH-1:0]   sq = d * d;

  // comparators
  assign i_lt_train  = (i < TRAIN_SIZE);
  assign j_lt_feat   = (j < FEATURE_COUNT);
  assign dist_lt_min = (distance < min_distance);

  assign predicted_class_out = predicted_class;

  // datapath logic
  always @(posedge clk) begin
    if (rst) begin
      i              <= 0;
      j              <= 0;
      distance       <= 0;
      min_distance   <= MAX_DISTANCE;
      predicted_class<= 0;
    end else begin
      // counters
      if (i_load)     i <= 0;
      else if (i_inc) i <= i + 1;

      if (j_load)     j <= 0;
      else if (j_inc) j <= j + 1;

      // distance accumulation
      if (dist_load)      distance <= 0;
      else if (dist_acc)  distance <= distance + sq;

      // update best
      if (min_load)   min_distance   <= distance;
      if (pred_load)  predicted_class<= current_label;
    end
  end

endmodule
