module top (
    input clk,
    input rst,
    output [1:0] final_class,

    // Debug outputs:
    output [7:0] debug_sample_index,
    output start_distance_dbg,
    output update_min_dbg,
    output done_dbg,
    output [1:0] predicted_label_dbg,
    output [31:0] min_distance_dbg
);

    wire [7:0] index;
    wire [1:0] train_label;
    wire [63:0] test_sample_flat;
    wire [63:0] train_sample_flat;

    // Hardcoded test sample
    //assign test_sample_flat = {16'h0633, 16'h0233, 16'h0480, 16'h0180};  // example
	 assign test_sample_flat = {16'h0200, 16'h06B3, 16'h02CD, 16'h07B3};
    wire start_distance, update_min;
    wire [31:0] min_distance;
    wire done;
    wire [1:0] pred_label;

    // Hook up controller
    controller ctrl (
        .clk(clk),
        .rst(rst),
        .sample_index(index),
        .start_distance(start_distance),
        .update_min(update_min),
        .done(done)
    );

    // Hook up datapath
    datapath dp (
        .clk(clk),
        .rst(rst),
        .sample_index(index),
        .test_sample_flat(test_sample_flat),
        .train_sample_flat(train_sample_flat),
        .train_label(train_label),
        .start_distance(start_distance),
        .update_min(update_min),
        .predicted_label(pred_label),
        .min_distance_out(min_distance)
    );

    // Hook up memory
    train_memory mem (
        .clk(clk),
        .addr(index),
        .features_flat(train_sample_flat),
        .label(train_label)
    );

    // Final output
    assign final_class = pred_label;

    // Debug wires
    assign debug_sample_index = index;
    assign start_distance_dbg = start_distance;
    assign update_min_dbg = update_min;
    assign done_dbg = done;
    assign predicted_label_dbg = pred_label;
    assign min_distance_dbg = min_distance;
endmodule
