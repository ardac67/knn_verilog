module controller (
    input clk,
    input rst,
    output reg [7:0] sample_index,
    output reg start_distance,
    output reg update_min,
    output reg done
);

    // State encoding
    reg [2:0] state;
    parameter IDLE = 3'd0, START = 3'd1, WAIT = 3'd2, UPDATE = 3'd3, NEXT = 3'd4;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sample_index <= 0;
            start_distance <= 0;
            update_min <= 0;
            done <= 0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    start_distance <= 0;
                    update_min <= 0;
                    if (!done) begin
                        state <= START;
                    end
                end

                START: begin
                    start_distance <= 1;
                    update_min <= 0;
                    state <= WAIT;
                end

                WAIT: begin
                    start_distance <= 0;  // Let datapath compute distance
                    update_min <= 0;
                    state <= UPDATE;
                end

                UPDATE: begin
                    update_min <= 1;      // Compare and maybe update
                    state <= NEXT;
                end

                NEXT: begin
                    update_min <= 0;
                    if (sample_index == 8'd149) begin
                        done <= 1;
                        state <= IDLE;
                    end else begin
                        sample_index <= sample_index + 1;
                        state <= START;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
