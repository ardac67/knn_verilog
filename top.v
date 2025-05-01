// in top.v
module top #(
  parameter TRAIN_SIZE    = 150,
  parameter FEATURE_COUNT =   4,
  parameter DATA_WIDTH    =  16,
  parameter LABEL_WIDTH   =   8
)(
  input  wire                           clk,
  input  wire                           rst,
  input  wire [FEATURE_COUNT*DATA_WIDTH-1:0] test_sample_flat,
  output wire [LABEL_WIDTH-1:0]         predicted_class,
  output wire                           done,

  // debug taps:
  output wire [3:0]                     dbg_state,   // controller state
  output wire [$clog2(FEATURE_COUNT)-1:0] dbg_j      // datapath j
);

  // these wires carry all the control signals…
  wire i_lt_train, j_lt_feat, dist_lt_min;
  wire i_load, i_inc, j_load, j_inc;
  wire dist_load, dist_acc, min_load, pred_load;

  // instantiate controller, *also* expose its state
  controller #(
    .TRAIN_SIZE    (TRAIN_SIZE),
    .FEATURE_COUNT (FEATURE_COUNT)
  ) ctrl (
    .clk          (clk),
    .rst          (rst),
    .i_lt_train   (i_lt_train),
    .j_lt_feat    (j_lt_feat),
    .dist_lt_min  (dist_lt_min),
    .i_load       (i_load),
    .i_inc        (i_inc),
    .j_load       (j_load),
    .j_inc        (j_inc),
    .dist_load    (dist_load),
    .dist_acc     (dist_acc),
    .min_load     (min_load),
    .pred_load    (pred_load),
    .done         (done),
    .state_out    (dbg_state)      // <— you’ll have to add this port
  );

  // instantiate datapath, *also* expose its j register
  datapath #(
    .TRAIN_SIZE    (TRAIN_SIZE),
    .FEATURE_COUNT (FEATURE_COUNT),
    .DATA_WIDTH    (DATA_WIDTH),
    .LABEL_WIDTH   (LABEL_WIDTH)
  ) dp (
    .clk                 (clk),
    .rst                 (rst),
    .i_load              (i_load),
    .i_inc               (i_inc),
    .j_load              (j_load),
    .j_inc               (j_inc),
    .dist_load           (dist_load),
    .dist_acc            (dist_acc),
    .min_load            (min_load),
    .pred_load           (pred_load),
    .test_sample_flat    (test_sample_flat),
    .i_lt_train          (i_lt_train),
    .j_lt_feat           (j_lt_feat),
    .dist_lt_min         (dist_lt_min),
    .predicted_class_out (predicted_class),
    .j_out               (dbg_j)     // <— you’ll have to add this port
  );

endmodule
