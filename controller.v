module controller #(
  parameter TRAIN_SIZE     = 150,
  parameter FEATURE_COUNT  = 4
)(
  input  wire clk,
  input  wire rst,             // synchronous, active‐high reset
  // comparator inputs from datapath
  input  wire i_lt_train,      // i < TRAIN_SIZE?
  input  wire j_lt_feat,       // j < FEATURE_COUNT?
  input  wire dist_lt_min,     // distance < min_distance?
  // control outputs to datapath
  output reg  i_load,          // load / clear i
  output reg  i_inc,           // increment i
  output reg  j_load,          // load / clear j
  output reg  j_inc,           // increment j
  output reg  dist_load,       // clear distance accumulator
  output reg  dist_acc,        // enable accumulate (diff*diff)
  output reg  min_load,        // load new min_distance
  output reg  pred_load,       // load new predicted_class
  output reg  done       ,      // goes high in DONE state
    output reg  [3:0]  state_out   // ← new
);

  //-------------------------------------------------------------------------
  // state encoding
  //-------------------------------------------------------------------------
  localparam 
    S_IDLE     = 4'd0,   // initialize i, min_distance, predicted_class
    S_CHECK_I  = 4'd1,   // if (i<TRAIN_SIZE) → S_INIT, else → S_DONE
    S_INIT     = 4'd2,   // dist=0, j=0
    S_CHECK_J  = 4'd3,   // if (j<FEATURE_COUNT) → S_CALC, else → S_COMPARE
    S_CALC     = 4'd4,   // do diff*diff + distance
    S_INC_J    = 4'd5,   // j++
    S_COMPARE  = 4'd6,   // if (distance<min) → S_UPDATE, else → S_INC_I
    S_UPDATE   = 4'd7,   // min = distance; predicted_class = train_labels[i]
    S_INC_I    = 4'd8,   // i++
    S_DONE     = 4'd9;   // finished

  reg [3:0] state, next_state;

  //-------------------------------------------------------------------------
  // state register
  //-------------------------------------------------------------------------
  always @(posedge clk) begin
    if (rst) 
      state <= S_IDLE;
    else
      state <= next_state;
	 state_out <= state;   
  end

  //-------------------------------------------------------------------------
  // next‐state logic
  //-------------------------------------------------------------------------
  always @* begin
    next_state = state;
    case(state)
      S_IDLE:     next_state = S_CHECK_I;
      S_CHECK_I:  next_state = i_lt_train ? S_INIT : S_DONE;
      S_INIT:     next_state = S_CHECK_J;
      S_CHECK_J:  next_state = j_lt_feat  ? S_CALC : S_COMPARE;
      S_CALC:     next_state = S_INC_J;
      S_INC_J:    next_state = S_CHECK_J;
      S_COMPARE:  next_state = dist_lt_min ? S_UPDATE : S_INC_I;
      S_UPDATE:   next_state = S_INC_I;
      S_INC_I:    next_state = S_CHECK_I;
      S_DONE:     next_state = S_DONE;
      default:    next_state = S_IDLE;
    endcase
  end

  //-------------------------------------------------------------------------
  // output logic (Moore) — assert only in the matching state
  //-------------------------------------------------------------------------
  always @* begin
    // default all‐zero
    i_load    = 1'b0;
    i_inc     = 1'b0;
    j_load    = 1'b0;
    j_inc     = 1'b0;
    dist_load = 1'b0;
    dist_acc  = 1'b0;
    min_load  = 1'b0;
    pred_load = 1'b0;
    done      = 1'b0;

    case(state)
      // S_IDLE: initialize all three registers at once
      S_IDLE: begin
        i_load    = 1;
        //min_load  = 1;
        pred_load = 1;
      end

      // S_INIT: clear distance accumulator and j counter
      S_INIT: begin
        dist_load = 1;
        j_load    = 1;
      end

      // S_CALC: enable the datapath to do distance += diff*diff
      S_CALC: begin
        dist_acc = 1;
      end

      // S_INC_J: increment j
      S_INC_J: begin
        j_inc = 1;
      end

      // S_UPDATE: distance < min → capture min and predicted_class
      S_UPDATE: begin
        min_load  = 1;
        pred_load = 1;
      end

      // S_INC_I: increment i
      S_INC_I: begin
        i_inc = 1;
      end

      // S_DONE: tell the outside world we’re done
      S_DONE: begin
        done = 1;
      end

    endcase
  end

endmodule
