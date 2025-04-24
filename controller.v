module controller (
    input  clk,
    input  rst,
    output reg [7:0] sample_index,
    output reg       start_distance,
    output reg       update_min,
    output reg       done
);

    // State encoding
    reg [2:0] state;
    parameter
        IDLE          = 3'd0,
        START         = 3'd1,
        WAIT          = 3'd2,
        UPDATE        = 3'd3,
        CHECK         = 3'd4,  // was NEXT’s decision logic
        INCR          = 3'd5,  // increment sample_index
        FINISH        = 3'd6;  // assert done

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sample_index   <= 8'd0;
            start_distance <= 1'b0;
            update_min     <= 1'b0;
            done           <= 1'b0;
            state          <= IDLE;
        end else begin
            // default de-assert control signals
            start_distance <= 1'b0;
            update_min     <= 1'b0;

            case (state)
                IDLE: begin
                    if (!done) state <= START;
                end

                START: begin
                    start_distance <= 1'b1;
                    state          <= WAIT;
                end

                WAIT: begin
                    // let datapath compute
                    state <= UPDATE;
                end

                UPDATE: begin
                    update_min <= 1'b1;
                    state      <= CHECK;
                end

                CHECK: begin
                    // decide whether we’ve reached the last sample
                    if (sample_index == 8'd149)
                        state <= FINISH;
                    else
                        state <= INCR;
                end

                INCR: begin
                    sample_index <= sample_index + 8'd1;
                    state        <= START;
                end

                FINISH: begin
                    done  <= 1'b1;
                    state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
