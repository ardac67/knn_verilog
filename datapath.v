module datapath (
    input clk,
    input rst,
    input [7:0] sample_index,
    input [63:0] test_sample_flat,    // 4 x 16 bits
    input [63:0] train_sample_flat,   // 4 x 16 bits
    input [1:0] train_label,
    input start_distance,
    input update_min,
    output reg [1:0] predicted_label,
    output reg [31:0] min_distance_out
);

    reg [15:0] test_sample [0:3];
    reg [15:0] train_sample [0:3];
    reg signed [31:0] diff;
    reg [31:0] distance;
    reg [31:0] temp_distance;
    integer i;

    // Unflatten inputs — purely combinational
    always @(*) begin
        for (i = 0; i < 4; i = i + 1) begin
            test_sample[i] = test_sample_flat[i*16 +: 16];
            train_sample[i] = train_sample_flat[i*16 +: 16];
        end
    end

    // Sequential logic for computing distance and updating minimum
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            distance <= 0;
            min_distance_out <= 32'hFFFFFFFF;
            predicted_label <= 0;
        end else begin
            if (start_distance) begin
                temp_distance = 0;
                for (i = 0; i < 4; i = i + 1) begin
                    diff = $signed(train_sample[i]) - $signed(test_sample[i]);
                    temp_distance = temp_distance + diff * diff;
                end
                distance <= temp_distance;
            end

            if (update_min && (distance < min_distance_out)) begin
                min_distance_out <= distance;
                predicted_label <= train_label;
            end
        end
    end
endmodule
