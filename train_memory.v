module train_memory (
    input wire clk,
    input wire [7:0] addr,
    output reg [63:0] features_flat,  // flattened: 4 x 16-bit = 64-bit
    output reg [1:0] label
);

    reg [15:0] data_mem [0:255][0:3];
    reg [1:0] label_mem [0:255];

    initial begin
				 data_mem[0][0] = 16'h051A;
				data_mem[0][1] = 16'h0380;
				data_mem[0][2] = 16'h0166;
				data_mem[0][3] = 16'h0033;
				label_mem[0] = 2'd0;

				data_mem[1][0] = 16'h04E6;
				data_mem[1][1] = 16'h0300;
				data_mem[1][2] = 16'h0166;
				data_mem[1][3] = 16'h0033;
				label_mem[1] = 2'd0;

				data_mem[2][0] = 16'h04B3;
				data_mem[2][1] = 16'h0333;
				data_mem[2][2] = 16'h014D;
				data_mem[2][3] = 16'h0033;
				label_mem[2] = 2'd0;

				data_mem[3][0] = 16'h049A;
				data_mem[3][1] = 16'h031A;
				data_mem[3][2] = 16'h0180;
				data_mem[3][3] = 16'h0033;
				label_mem[3] = 2'd0;

				data_mem[4][0] = 16'h0500;
				data_mem[4][1] = 16'h039A;
				data_mem[4][2] = 16'h0166;
				data_mem[4][3] = 16'h0033;
				label_mem[4] = 2'd0;

				data_mem[5][0] = 16'h0566;
				data_mem[5][1] = 16'h03E6;
				data_mem[5][2] = 16'h01B3;
				data_mem[5][3] = 16'h0066;
				label_mem[5] = 2'd0;

				data_mem[6][0] = 16'h049A;
				data_mem[6][1] = 16'h0366;
				data_mem[6][2] = 16'h0166;
				data_mem[6][3] = 16'h004D;
				label_mem[6] = 2'd0;

				data_mem[7][0] = 16'h0500;
				data_mem[7][1] = 16'h0366;
				data_mem[7][2] = 16'h0180;
				data_mem[7][3] = 16'h0033;
				label_mem[7] = 2'd0;

				data_mem[8][0] = 16'h0466;
				data_mem[8][1] = 16'h02E6;
				data_mem[8][2] = 16'h0166;
				data_mem[8][3] = 16'h0033;
				label_mem[8] = 2'd0;

				data_mem[9][0] = 16'h04E6;
				data_mem[9][1] = 16'h031A;
				data_mem[9][2] = 16'h0180;
				data_mem[9][3] = 16'h001A;
				label_mem[9] = 2'd0;

				data_mem[10][0] = 16'h0566;
				data_mem[10][1] = 16'h03B3;
				data_mem[10][2] = 16'h0180;
				data_mem[10][3] = 16'h0033;
				label_mem[10] = 2'd0;

				data_mem[11][0] = 16'h04CD;
				data_mem[11][1] = 16'h0366;
				data_mem[11][2] = 16'h019A;
				data_mem[11][3] = 16'h0033;
				label_mem[11] = 2'd0;

				data_mem[12][0] = 16'h04CD;
				data_mem[12][1] = 16'h0300;
				data_mem[12][2] = 16'h0166;
				data_mem[12][3] = 16'h001A;
				label_mem[12] = 2'd0;

				data_mem[13][0] = 16'h044D;
				data_mem[13][1] = 16'h0300;
				data_mem[13][2] = 16'h011A;
				data_mem[13][3] = 16'h001A;
				label_mem[13] = 2'd0;

				data_mem[14][0] = 16'h05CD;
				data_mem[14][1] = 16'h0400;
				data_mem[14][2] = 16'h0133;
				data_mem[14][3] = 16'h0033;
				label_mem[14] = 2'd0;

				data_mem[15][0] = 16'h05B3;
				data_mem[15][1] = 16'h0466;
				data_mem[15][2] = 16'h0180;
				data_mem[15][3] = 16'h0066;
				label_mem[15] = 2'd0;

				data_mem[16][0] = 16'h0566;
				data_mem[16][1] = 16'h03E6;
				data_mem[16][2] = 16'h014D;
				data_mem[16][3] = 16'h0066;
				label_mem[16] = 2'd0;

				data_mem[17][0] = 16'h051A;
				data_mem[17][1] = 16'h0380;
				data_mem[17][2] = 16'h0166;
				data_mem[17][3] = 16'h004D;
				label_mem[17] = 2'd0;

				data_mem[18][0] = 16'h05B3;
				data_mem[18][1] = 16'h03CD;
				data_mem[18][2] = 16'h01B3;
				data_mem[18][3] = 16'h004D;
				label_mem[18] = 2'd0;

				data_mem[19][0] = 16'h051A;
				data_mem[19][1] = 16'h03CD;
				data_mem[19][2] = 16'h0180;
				data_mem[19][3] = 16'h004D;
				label_mem[19] = 2'd0;

				data_mem[20][0] = 16'h0566;
				data_mem[20][1] = 16'h0366;
				data_mem[20][2] = 16'h01B3;
				data_mem[20][3] = 16'h0033;
				label_mem[20] = 2'd0;

				data_mem[21][0] = 16'h051A;
				data_mem[21][1] = 16'h03B3;
				data_mem[21][2] = 16'h0180;
				data_mem[21][3] = 16'h0066;
				label_mem[21] = 2'd0;

				data_mem[22][0] = 16'h049A;
				data_mem[22][1] = 16'h039A;
				data_mem[22][2] = 16'h0100;
				data_mem[22][3] = 16'h0033;
				label_mem[22] = 2'd0;

				data_mem[23][0] = 16'h051A;
				data_mem[23][1] = 16'h034D;
				data_mem[23][2] = 16'h01B3;
				data_mem[23][3] = 16'h0080;
				label_mem[23] = 2'd0;

				data_mem[24][0] = 16'h04CD;
				data_mem[24][1] = 16'h0366;
				data_mem[24][2] = 16'h01E6;
				data_mem[24][3] = 16'h0033;
				label_mem[24] = 2'd0;

				data_mem[25][0] = 16'h0500;
				data_mem[25][1] = 16'h0300;
				data_mem[25][2] = 16'h019A;
				data_mem[25][3] = 16'h0033;
				label_mem[25] = 2'd0;

				data_mem[26][0] = 16'h0500;
				data_mem[26][1] = 16'h0366;
				data_mem[26][2] = 16'h019A;
				data_mem[26][3] = 16'h0066;
				label_mem[26] = 2'd0;

				data_mem[27][0] = 16'h0533;
				data_mem[27][1] = 16'h0380;
				data_mem[27][2] = 16'h0180;
				data_mem[27][3] = 16'h0033;
				label_mem[27] = 2'd0;

				data_mem[28][0] = 16'h0533;
				data_mem[28][1] = 16'h0366;
				data_mem[28][2] = 16'h0166;
				data_mem[28][3] = 16'h0033;
				label_mem[28] = 2'd0;

				data_mem[29][0] = 16'h04B3;
				data_mem[29][1] = 16'h0333;
				data_mem[29][2] = 16'h019A;
				data_mem[29][3] = 16'h0033;
				label_mem[29] = 2'd0;

				data_mem[30][0] = 16'h04CD;
				data_mem[30][1] = 16'h031A;
				data_mem[30][2] = 16'h019A;
				data_mem[30][3] = 16'h0033;
				label_mem[30] = 2'd0;

				data_mem[31][0] = 16'h0566;
				data_mem[31][1] = 16'h0366;
				data_mem[31][2] = 16'h0180;
				data_mem[31][3] = 16'h0066;
				label_mem[31] = 2'd0;

				data_mem[32][0] = 16'h0533;
				data_mem[32][1] = 16'h041A;
				data_mem[32][2] = 16'h0180;
				data_mem[32][3] = 16'h001A;
				label_mem[32] = 2'd0;

				data_mem[33][0] = 16'h0580;
				data_mem[33][1] = 16'h0433;
				data_mem[33][2] = 16'h0166;
				data_mem[33][3] = 16'h0033;
				label_mem[33] = 2'd0;

				data_mem[34][0] = 16'h04E6;
				data_mem[34][1] = 16'h031A;
				data_mem[34][2] = 16'h0180;
				data_mem[34][3] = 16'h0033;
				label_mem[34] = 2'd0;

				data_mem[35][0] = 16'h0500;
				data_mem[35][1] = 16'h0333;
				data_mem[35][2] = 16'h0133;
				data_mem[35][3] = 16'h0033;
				label_mem[35] = 2'd0;

				data_mem[36][0] = 16'h0580;
				data_mem[36][1] = 16'h0380;
				data_mem[36][2] = 16'h014D;
				data_mem[36][3] = 16'h0033;
				label_mem[36] = 2'd0;

				data_mem[37][0] = 16'h04E6;
				data_mem[37][1] = 16'h039A;
				data_mem[37][2] = 16'h0166;
				data_mem[37][3] = 16'h001A;
				label_mem[37] = 2'd0;

				data_mem[38][0] = 16'h0466;
				data_mem[38][1] = 16'h0300;
				data_mem[38][2] = 16'h014D;
				data_mem[38][3] = 16'h0033;
				label_mem[38] = 2'd0;

				data_mem[39][0] = 16'h051A;
				data_mem[39][1] = 16'h0366;
				data_mem[39][2] = 16'h0180;
				data_mem[39][3] = 16'h0033;
				label_mem[39] = 2'd0;

				data_mem[40][0] = 16'h0500;
				data_mem[40][1] = 16'h0380;
				data_mem[40][2] = 16'h014D;
				data_mem[40][3] = 16'h004D;
				label_mem[40] = 2'd0;

				data_mem[41][0] = 16'h0480;
				data_mem[41][1] = 16'h024D;
				data_mem[41][2] = 16'h014D;
				data_mem[41][3] = 16'h004D;
				label_mem[41] = 2'd0;

				data_mem[42][0] = 16'h0466;
				data_mem[42][1] = 16'h0333;
				data_mem[42][2] = 16'h014D;
				data_mem[42][3] = 16'h0033;
				label_mem[42] = 2'd0;

				data_mem[43][0] = 16'h0500;
				data_mem[43][1] = 16'h0380;
				data_mem[43][2] = 16'h019A;
				data_mem[43][3] = 16'h009A;
				label_mem[43] = 2'd0;

				data_mem[44][0] = 16'h051A;
				data_mem[44][1] = 16'h03CD;
				data_mem[44][2] = 16'h01E6;
				data_mem[44][3] = 16'h0066;
				label_mem[44] = 2'd0;

				data_mem[45][0] = 16'h04CD;
				data_mem[45][1] = 16'h0300;
				data_mem[45][2] = 16'h0166;
				data_mem[45][3] = 16'h004D;
				label_mem[45] = 2'd0;

				data_mem[46][0] = 16'h051A;
				data_mem[46][1] = 16'h03CD;
				data_mem[46][2] = 16'h019A;
				data_mem[46][3] = 16'h0033;
				label_mem[46] = 2'd0;

				data_mem[47][0] = 16'h049A;
				data_mem[47][1] = 16'h0333;
				data_mem[47][2] = 16'h0166;
				data_mem[47][3] = 16'h0033;
				label_mem[47] = 2'd0;

				data_mem[48][0] = 16'h054D;
				data_mem[48][1] = 16'h03B3;
				data_mem[48][2] = 16'h0180;
				data_mem[48][3] = 16'h0033;
				label_mem[48] = 2'd0;

				data_mem[49][0] = 16'h0500;
				data_mem[49][1] = 16'h034D;
				data_mem[49][2] = 16'h0166;
				data_mem[49][3] = 16'h0033;
				label_mem[49] = 2'd0;

				data_mem[50][0] = 16'h0700;
				data_mem[50][1] = 16'h0333;
				data_mem[50][2] = 16'h04B3;
				data_mem[50][3] = 16'h0166;
				label_mem[50] = 2'd1;

				data_mem[51][0] = 16'h0666;
				data_mem[51][1] = 16'h0333;
				data_mem[51][2] = 16'h0480;
				data_mem[51][3] = 16'h0180;
				label_mem[51] = 2'd1;

				data_mem[52][0] = 16'h06E6;
				data_mem[52][1] = 16'h031A;
				data_mem[52][2] = 16'h04E6;
				data_mem[52][3] = 16'h0180;
				label_mem[52] = 2'd1;

				data_mem[53][0] = 16'h0580;
				data_mem[53][1] = 16'h024D;
				data_mem[53][2] = 16'h0400;
				data_mem[53][3] = 16'h014D;
				label_mem[53] = 2'd1;

				data_mem[54][0] = 16'h0680;
				data_mem[54][1] = 16'h02CD;
				data_mem[54][2] = 16'h049A;
				data_mem[54][3] = 16'h0180;
				label_mem[54] = 2'd1;

				data_mem[55][0] = 16'h05B3;
				data_mem[55][1] = 16'h02CD;
				data_mem[55][2] = 16'h0480;
				data_mem[55][3] = 16'h014D;
				label_mem[55] = 2'd1;

				data_mem[56][0] = 16'h064D;
				data_mem[56][1] = 16'h034D;
				data_mem[56][2] = 16'h04B3;
				data_mem[56][3] = 16'h019A;
				label_mem[56] = 2'd1;

				data_mem[57][0] = 16'h04E6;
				data_mem[57][1] = 16'h0266;
				data_mem[57][2] = 16'h034D;
				data_mem[57][3] = 16'h0100;
				label_mem[57] = 2'd1;

				data_mem[58][0] = 16'h069A;
				data_mem[58][1] = 16'h02E6;
				data_mem[58][2] = 16'h049A;
				data_mem[58][3] = 16'h014D;
				label_mem[58] = 2'd1;

				data_mem[59][0] = 16'h0533;
				data_mem[59][1] = 16'h02B3;
				data_mem[59][2] = 16'h03E6;
				data_mem[59][3] = 16'h0166;
				label_mem[59] = 2'd1;

				data_mem[60][0] = 16'h0500;
				data_mem[60][1] = 16'h0200;
				data_mem[60][2] = 16'h0380;
				data_mem[60][3] = 16'h0100;
				label_mem[60] = 2'd1;

				data_mem[61][0] = 16'h05E6;
				data_mem[61][1] = 16'h0300;
				data_mem[61][2] = 16'h0433;
				data_mem[61][3] = 16'h0180;
				label_mem[61] = 2'd1;

				data_mem[62][0] = 16'h0600;
				data_mem[62][1] = 16'h0233;
				data_mem[62][2] = 16'h0400;
				data_mem[62][3] = 16'h0100;
				label_mem[62] = 2'd1;

				data_mem[63][0] = 16'h061A;
				data_mem[63][1] = 16'h02E6;
				data_mem[63][2] = 16'h04B3;
				data_mem[63][3] = 16'h0166;
				label_mem[63] = 2'd1;

				data_mem[64][0] = 16'h059A;
				data_mem[64][1] = 16'h02E6;
				data_mem[64][2] = 16'h039A;
				data_mem[64][3] = 16'h014D;
				label_mem[64] = 2'd1;

				data_mem[65][0] = 16'h06B3;
				data_mem[65][1] = 16'h031A;
				data_mem[65][2] = 16'h0466;
				data_mem[65][3] = 16'h0166;
				label_mem[65] = 2'd1;

				data_mem[66][0] = 16'h059A;
				data_mem[66][1] = 16'h0300;
				data_mem[66][2] = 16'h0480;
				data_mem[66][3] = 16'h0180;
				label_mem[66] = 2'd1;

				data_mem[67][0] = 16'h05CD;
				data_mem[67][1] = 16'h02B3;
				data_mem[67][2] = 16'h041A;
				data_mem[67][3] = 16'h0100;
				label_mem[67] = 2'd1;

				data_mem[68][0] = 16'h0633;
				data_mem[68][1] = 16'h0233;
				data_mem[68][2] = 16'h0480;
				data_mem[68][3] = 16'h0180;
				label_mem[68] = 2'd1;

				data_mem[69][0] = 16'h059A;
				data_mem[69][1] = 16'h0280;
				data_mem[69][2] = 16'h03E6;
				data_mem[69][3] = 16'h011A;
				label_mem[69] = 2'd1;

				data_mem[70][0] = 16'h05E6;
				data_mem[70][1] = 16'h0333;
				data_mem[70][2] = 16'h04CD;
				data_mem[70][3] = 16'h01CD;
				label_mem[70] = 2'd1;

				data_mem[71][0] = 16'h061A;
				data_mem[71][1] = 16'h02CD;
				data_mem[71][2] = 16'h0400;
				data_mem[71][3] = 16'h014D;
				label_mem[71] = 2'd1;

				data_mem[72][0] = 16'h064D;
				data_mem[72][1] = 16'h0280;
				data_mem[72][2] = 16'h04E6;
				data_mem[72][3] = 16'h0180;
				label_mem[72] = 2'd1;

				data_mem[73][0] = 16'h061A;
				data_mem[73][1] = 16'h02CD;
				data_mem[73][2] = 16'h04B3;
				data_mem[73][3] = 16'h0133;
				label_mem[73] = 2'd1;

				data_mem[74][0] = 16'h0666;
				data_mem[74][1] = 16'h02E6;
				data_mem[74][2] = 16'h044D;
				data_mem[74][3] = 16'h014D;
				label_mem[74] = 2'd1;

				data_mem[75][0] = 16'h069A;
				data_mem[75][1] = 16'h0300;
				data_mem[75][2] = 16'h0466;
				data_mem[75][3] = 16'h0166;
				label_mem[75] = 2'd1;

				data_mem[76][0] = 16'h06CD;
				data_mem[76][1] = 16'h02CD;
				data_mem[76][2] = 16'h04CD;
				data_mem[76][3] = 16'h0166;
				label_mem[76] = 2'd1;

				data_mem[77][0] = 16'h06B3;
				data_mem[77][1] = 16'h0300;
				data_mem[77][2] = 16'h0500;
				data_mem[77][3] = 16'h01B3;
				label_mem[77] = 2'd1;

				data_mem[78][0] = 16'h0600;
				data_mem[78][1] = 16'h02E6;
				data_mem[78][2] = 16'h0480;
				data_mem[78][3] = 16'h0180;
				label_mem[78] = 2'd1;

				data_mem[79][0] = 16'h05B3;
				data_mem[79][1] = 16'h029A;
				data_mem[79][2] = 16'h0380;
				data_mem[79][3] = 16'h0100;
				label_mem[79] = 2'd1;

				data_mem[80][0] = 16'h0580;
				data_mem[80][1] = 16'h0266;
				data_mem[80][2] = 16'h03CD;
				data_mem[80][3] = 16'h011A;
				label_mem[80] = 2'd1;

				data_mem[81][0] = 16'h0580;
				data_mem[81][1] = 16'h0266;
				data_mem[81][2] = 16'h03B3;
				data_mem[81][3] = 16'h0100;
				label_mem[81] = 2'd1;

				data_mem[82][0] = 16'h05CD;
				data_mem[82][1] = 16'h02B3;
				data_mem[82][2] = 16'h03E6;
				data_mem[82][3] = 16'h0133;
				label_mem[82] = 2'd1;

				data_mem[83][0] = 16'h0600;
				data_mem[83][1] = 16'h02B3;
				data_mem[83][2] = 16'h051A;
				data_mem[83][3] = 16'h019A;
				label_mem[83] = 2'd1;

				data_mem[84][0] = 16'h0566;
				data_mem[84][1] = 16'h0300;
				data_mem[84][2] = 16'h0480;
				data_mem[84][3] = 16'h0180;
				label_mem[84] = 2'd1;

				data_mem[85][0] = 16'h0600;
				data_mem[85][1] = 16'h0366;
				data_mem[85][2] = 16'h0480;
				data_mem[85][3] = 16'h019A;
				label_mem[85] = 2'd1;

				data_mem[86][0] = 16'h06B3;
				data_mem[86][1] = 16'h031A;
				data_mem[86][2] = 16'h04B3;
				data_mem[86][3] = 16'h0180;
				label_mem[86] = 2'd1;

				data_mem[87][0] = 16'h064D;
				data_mem[87][1] = 16'h024D;
				data_mem[87][2] = 16'h0466;
				data_mem[87][3] = 16'h014D;
				label_mem[87] = 2'd1;

				data_mem[88][0] = 16'h059A;
				data_mem[88][1] = 16'h0300;
				data_mem[88][2] = 16'h041A;
				data_mem[88][3] = 16'h014D;
				label_mem[88] = 2'd1;

				data_mem[89][0] = 16'h0580;
				data_mem[89][1] = 16'h0280;
				data_mem[89][2] = 16'h0400;
				data_mem[89][3] = 16'h014D;
				label_mem[89] = 2'd1;

				data_mem[90][0] = 16'h0580;
				data_mem[90][1] = 16'h029A;
				data_mem[90][2] = 16'h0466;
				data_mem[90][3] = 16'h0133;
				label_mem[90] = 2'd1;

				data_mem[91][0] = 16'h061A;
				data_mem[91][1] = 16'h0300;
				data_mem[91][2] = 16'h049A;
				data_mem[91][3] = 16'h0166;
				label_mem[91] = 2'd1;

				data_mem[92][0] = 16'h05CD;
				data_mem[92][1] = 16'h029A;
				data_mem[92][2] = 16'h0400;
				data_mem[92][3] = 16'h0133;
				label_mem[92] = 2'd1;

				data_mem[93][0] = 16'h0500;
				data_mem[93][1] = 16'h024D;
				data_mem[93][2] = 16'h034D;
				data_mem[93][3] = 16'h0100;
				label_mem[93] = 2'd1;

				data_mem[94][0] = 16'h059A;
				data_mem[94][1] = 16'h02B3;
				data_mem[94][2] = 16'h0433;
				data_mem[94][3] = 16'h014D;
				label_mem[94] = 2'd1;

				data_mem[95][0] = 16'h05B3;
				data_mem[95][1] = 16'h0300;
				data_mem[95][2] = 16'h0433;
				data_mem[95][3] = 16'h0133;
				label_mem[95] = 2'd1;

				data_mem[96][0] = 16'h05B3;
				data_mem[96][1] = 16'h02E6;
				data_mem[96][2] = 16'h0433;
				data_mem[96][3] = 16'h014D;
				label_mem[96] = 2'd1;

				data_mem[97][0] = 16'h0633;
				data_mem[97][1] = 16'h02E6;
				data_mem[97][2] = 16'h044D;
				data_mem[97][3] = 16'h014D;
				label_mem[97] = 2'd1;

				data_mem[98][0] = 16'h051A;
				data_mem[98][1] = 16'h0280;
				data_mem[98][2] = 16'h0300;
				data_mem[98][3] = 16'h011A;
				label_mem[98] = 2'd1;

				data_mem[99][0] = 16'h05B3;
				data_mem[99][1] = 16'h02CD;
				data_mem[99][2] = 16'h041A;
				data_mem[99][3] = 16'h014D;
				label_mem[99] = 2'd1;

				data_mem[100][0] = 16'h064D;
				data_mem[100][1] = 16'h034D;
				data_mem[100][2] = 16'h0600;
				data_mem[100][3] = 16'h0280;
				label_mem[100] = 2'd2;

				data_mem[101][0] = 16'h05CD;
				data_mem[101][1] = 16'h02B3;
				data_mem[101][2] = 16'h051A;
				data_mem[101][3] = 16'h01E6;
				label_mem[101] = 2'd2;

				data_mem[102][0] = 16'h071A;
				data_mem[102][1] = 16'h0300;
				data_mem[102][2] = 16'h05E6;
				data_mem[102][3] = 16'h021A;
				label_mem[102] = 2'd2;

				data_mem[103][0] = 16'h064D;
				data_mem[103][1] = 16'h02E6;
				data_mem[103][2] = 16'h059A;
				data_mem[103][3] = 16'h01CD;
				label_mem[103] = 2'd2;

				data_mem[104][0] = 16'h0680;
				data_mem[104][1] = 16'h0300;
				data_mem[104][2] = 16'h05CD;
				data_mem[104][3] = 16'h0233;
				label_mem[104] = 2'd2;

				data_mem[105][0] = 16'h079A;
				data_mem[105][1] = 16'h0300;
				data_mem[105][2] = 16'h069A;
				data_mem[105][3] = 16'h021A;
				label_mem[105] = 2'd2;

				data_mem[106][0] = 16'h04E6;
				data_mem[106][1] = 16'h0280;
				data_mem[106][2] = 16'h0480;
				data_mem[106][3] = 16'h01B3;
				label_mem[106] = 2'd2;

				data_mem[107][0] = 16'h074D;
				data_mem[107][1] = 16'h02E6;
				data_mem[107][2] = 16'h064D;
				data_mem[107][3] = 16'h01CD;
				label_mem[107] = 2'd2;

				data_mem[108][0] = 16'h06B3;
				data_mem[108][1] = 16'h0280;
				data_mem[108][2] = 16'h05CD;
				data_mem[108][3] = 16'h01CD;
				label_mem[108] = 2'd2;

				data_mem[109][0] = 16'h0733;
				data_mem[109][1] = 16'h039A;
				data_mem[109][2] = 16'h061A;
				data_mem[109][3] = 16'h0280;
				label_mem[109] = 2'd2;

				data_mem[110][0] = 16'h0680;
				data_mem[110][1] = 16'h0333;
				data_mem[110][2] = 16'h051A;
				data_mem[110][3] = 16'h0200;
				label_mem[110] = 2'd2;

				data_mem[111][0] = 16'h0666;
				data_mem[111][1] = 16'h02B3;
				data_mem[111][2] = 16'h054D;
				data_mem[111][3] = 16'h01E6;
				label_mem[111] = 2'd2;

				data_mem[112][0] = 16'h06CD;
				data_mem[112][1] = 16'h0300;
				data_mem[112][2] = 16'h0580;
				data_mem[112][3] = 16'h021A;
				label_mem[112] = 2'd2;

				data_mem[113][0] = 16'h05B3;
				data_mem[113][1] = 16'h0280;
				data_mem[113][2] = 16'h0500;
				data_mem[113][3] = 16'h0200;
				label_mem[113] = 2'd2;

				data_mem[114][0] = 16'h05CD;
				data_mem[114][1] = 16'h02CD;
				data_mem[114][2] = 16'h051A;
				data_mem[114][3] = 16'h0266;
				label_mem[114] = 2'd2;

				data_mem[115][0] = 16'h0666;
				data_mem[115][1] = 16'h0333;
				data_mem[115][2] = 16'h054D;
				data_mem[115][3] = 16'h024D;
				label_mem[115] = 2'd2;

				data_mem[116][0] = 16'h0680;
				data_mem[116][1] = 16'h0300;
				data_mem[116][2] = 16'h0580;
				data_mem[116][3] = 16'h01CD;
				label_mem[116] = 2'd2;

				data_mem[117][0] = 16'h07B3;
				data_mem[117][1] = 16'h03CD;
				data_mem[117][2] = 16'h06B3;
				data_mem[117][3] = 16'h0233;
				label_mem[117] = 2'd2;

				data_mem[118][0] = 16'h07B3;
				data_mem[118][1] = 16'h029A;
				data_mem[118][2] = 16'h06E6;
				data_mem[118][3] = 16'h024D;
				label_mem[118] = 2'd2;

				data_mem[119][0] = 16'h0600;
				data_mem[119][1] = 16'h0233;
				data_mem[119][2] = 16'h0500;
				data_mem[119][3] = 16'h0180;
				label_mem[119] = 2'd2;

				data_mem[120][0] = 16'h06E6;
				data_mem[120][1] = 16'h0333;
				data_mem[120][2] = 16'h05B3;
				data_mem[120][3] = 16'h024D;
				label_mem[120] = 2'd2;

				data_mem[121][0] = 16'h059A;
				data_mem[121][1] = 16'h02CD;
				data_mem[121][2] = 16'h04E6;
				data_mem[121][3] = 16'h0200;
				label_mem[121] = 2'd2;

				data_mem[122][0] = 16'h07B3;
				data_mem[122][1] = 16'h02CD;
				data_mem[122][2] = 16'h06B3;
				data_mem[122][3] = 16'h0200;
				label_mem[122] = 2'd2;

				data_mem[123][0] = 16'h064D;
				data_mem[123][1] = 16'h02B3;
				data_mem[123][2] = 16'h04E6;
				data_mem[123][3] = 16'h01CD;
				label_mem[123] = 2'd2;

				data_mem[124][0] = 16'h06B3;
				data_mem[124][1] = 16'h034D;
				data_mem[124][2] = 16'h05B3;
				data_mem[124][3] = 16'h021A;
				label_mem[124] = 2'd2;

				data_mem[125][0] = 16'h0733;
				data_mem[125][1] = 16'h0333;
				data_mem[125][2] = 16'h0600;
				data_mem[125][3] = 16'h01CD;
				label_mem[125] = 2'd2;

				data_mem[126][0] = 16'h0633;
				data_mem[126][1] = 16'h02CD;
				data_mem[126][2] = 16'h04CD;
				data_mem[126][3] = 16'h01CD;
				label_mem[126] = 2'd2;

				data_mem[127][0] = 16'h061A;
				data_mem[127][1] = 16'h0300;
				data_mem[127][2] = 16'h04E6;
				data_mem[127][3] = 16'h01CD;
				label_mem[127] = 2'd2;

				data_mem[128][0] = 16'h0666;
				data_mem[128][1] = 16'h02CD;
				data_mem[128][2] = 16'h059A;
				data_mem[128][3] = 16'h021A;
				label_mem[128] = 2'd2;

				data_mem[129][0] = 16'h0733;
				data_mem[129][1] = 16'h0300;
				data_mem[129][2] = 16'h05CD;
				data_mem[129][3] = 16'h019A;
				label_mem[129] = 2'd2;

				data_mem[130][0] = 16'h0766;
				data_mem[130][1] = 16'h02CD;
				data_mem[130][2] = 16'h061A;
				data_mem[130][3] = 16'h01E6;
				label_mem[130] = 2'd2;

				data_mem[131][0] = 16'h07E6;
				data_mem[131][1] = 16'h03CD;
				data_mem[131][2] = 16'h0666;
				data_mem[131][3] = 16'h0200;
				label_mem[131] = 2'd2;

				data_mem[132][0] = 16'h0666;
				data_mem[132][1] = 16'h02CD;
				data_mem[132][2] = 16'h059A;
				data_mem[132][3] = 16'h0233;
				label_mem[132] = 2'd2;

				data_mem[133][0] = 16'h064D;
				data_mem[133][1] = 16'h02CD;
				data_mem[133][2] = 16'h051A;
				data_mem[133][3] = 16'h0180;
				label_mem[133] = 2'd2;

				data_mem[134][0] = 16'h061A;
				data_mem[134][1] = 16'h029A;
				data_mem[134][2] = 16'h059A;
				data_mem[134][3] = 16'h0166;
				label_mem[134] = 2'd2;

				data_mem[135][0] = 16'h07B3;
				data_mem[135][1] = 16'h0300;
				data_mem[135][2] = 16'h061A;
				data_mem[135][3] = 16'h024D;
				label_mem[135] = 2'd2;

				data_mem[136][0] = 16'h064D;
				data_mem[136][1] = 16'h0366;
				data_mem[136][2] = 16'h059A;
				data_mem[136][3] = 16'h0266;
				label_mem[136] = 2'd2;

				data_mem[137][0] = 16'h0666;
				data_mem[137][1] = 16'h031A;
				data_mem[137][2] = 16'h0580;
				data_mem[137][3] = 16'h01CD;
				label_mem[137] = 2'd2;

				data_mem[138][0] = 16'h0600;
				data_mem[138][1] = 16'h0300;
				data_mem[138][2] = 16'h04CD;
				data_mem[138][3] = 16'h01CD;
				label_mem[138] = 2'd2;

				data_mem[139][0] = 16'h06E6;
				data_mem[139][1] = 16'h031A;
				data_mem[139][2] = 16'h0566;
				data_mem[139][3] = 16'h021A;
				label_mem[139] = 2'd2;

				data_mem[140][0] = 16'h06B3;
				data_mem[140][1] = 16'h031A;
				data_mem[140][2] = 16'h059A;
				data_mem[140][3] = 16'h0266;
				label_mem[140] = 2'd2;

				data_mem[141][0] = 16'h06E6;
				data_mem[141][1] = 16'h031A;
				data_mem[141][2] = 16'h051A;
				data_mem[141][3] = 16'h024D;
				label_mem[141] = 2'd2;

				data_mem[142][0] = 16'h05CD;
				data_mem[142][1] = 16'h02B3;
				data_mem[142][2] = 16'h051A;
				data_mem[142][3] = 16'h01E6;
				label_mem[142] = 2'd2;

				data_mem[143][0] = 16'h06CD;
				data_mem[143][1] = 16'h0333;
				data_mem[143][2] = 16'h05E6;
				data_mem[143][3] = 16'h024D;
				label_mem[143] = 2'd2;

				data_mem[144][0] = 16'h06B3;
				data_mem[144][1] = 16'h034D;
				data_mem[144][2] = 16'h05B3;
				data_mem[144][3] = 16'h0280;
				label_mem[144] = 2'd2;

				data_mem[145][0] = 16'h06B3;
				data_mem[145][1] = 16'h0300;
				data_mem[145][2] = 16'h0533;
				data_mem[145][3] = 16'h024D;
				label_mem[145] = 2'd2;

				data_mem[146][0] = 16'h064D;
				data_mem[146][1] = 16'h0280;
				data_mem[146][2] = 16'h0500;
				data_mem[146][3] = 16'h01E6;
				label_mem[146] = 2'd2;

				data_mem[147][0] = 16'h0680;
				data_mem[147][1] = 16'h0300;
				data_mem[147][2] = 16'h0533;
				data_mem[147][3] = 16'h0200;
				label_mem[147] = 2'd2;

				data_mem[148][0] = 16'h0633;
				data_mem[148][1] = 16'h0366;
				data_mem[148][2] = 16'h0566;
				data_mem[148][3] = 16'h024D;
				label_mem[148] = 2'd2;

				data_mem[149][0] = 16'h05E6;
				data_mem[149][1] = 16'h0300;
				data_mem[149][2] = 16'h051A;
				data_mem[149][3] = 16'h01CD;
				label_mem[149] = 2'd2;


    end
	always @(posedge clk) begin
		 label <= label_mem[addr];

		 // Flatten 4x16-bit features into a 64-bit vector
		 features_flat <= {
			  data_mem[addr][3],
			  data_mem[addr][2],
			  data_mem[addr][1],
			  data_mem[addr][0]
		 };
	end



endmodule
