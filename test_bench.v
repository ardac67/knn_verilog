module test_bench;
    reg clk;
    reg rst;

    wire [1:0] final_class;
    wire [7:0] debug_sample_index;
    wire start_distance_dbg;
    wire update_min_dbg;
    wire done_dbg;
    wire [1:0] predicted_label_dbg;
    wire [31:0] min_distance_dbg;

    top uut (
        .clk(clk),
        .rst(rst),
        .final_class(final_class),
        .debug_sample_index(debug_sample_index),
        .start_distance_dbg(start_distance_dbg),
        .update_min_dbg(update_min_dbg),
        .done_dbg(done_dbg),
        .predicted_label_dbg(predicted_label_dbg),
        .min_distance_dbg(min_distance_dbg)
    );

    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // Print progress every cycle
    always @(posedge clk) begin
        $display("Cycle %0t: idx=%d | start=%b | update=%b | min_dist=%d | pred_label=%d | done=%b", 
                 $time, debug_sample_index, start_distance_dbg, update_min_dbg, 
                 min_distance_dbg, predicted_label_dbg, done_dbg);
    end

    initial begin
        wait (done_dbg == 1);
		  #10;
        $display("Final Predicted Class = %d", final_class);
        $finish;
    end
endmodule
