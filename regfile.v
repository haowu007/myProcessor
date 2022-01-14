module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	
	
	
	//reg [31:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14,reg15;
	//reg [31:0] reg16,reg17,reg18,reg19,reg20,reg21,reg22,reg23,reg24,reg25,reg26,reg27,reg28,reg29,reg30,reg31;
   wire[31:0] write_en;
	wire[31:0] Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11,Q12,Q13,Q14,Q15,Q16,Q17,Q18,Q19,Q20,Q21,Q22,Q23,Q24,Q25,Q26,Q27,Q28,Q29,Q30,Q31;
	wire[31:0] en1;
	
	decoder_32to1 de1(ctrl_writeReg[4:0],write_en[31:0]);
	AND_32bit and1(en1[31:0],write_en[31:0], ctrl_writeEnable);
	

   dffe_ref d0(Q0[31:0],  data_writeReg[31:0] , clock, en1[0], ctrl_reset);
	dffe_ref d1(Q1[31:0],  data_writeReg[31:0] , clock, en1[1], ctrl_reset);
	dffe_ref d2(Q2[31:0],  data_writeReg[31:0] , clock, en1[2], ctrl_reset);
	dffe_ref d3(Q3[31:0],  data_writeReg[31:0] , clock, en1[3], ctrl_reset);
	dffe_ref d4(Q4[31:0],  data_writeReg[31:0] , clock, en1[4], ctrl_reset);
	dffe_ref d5(Q5[31:0],  data_writeReg[31:0] , clock, en1[5], ctrl_reset);
	dffe_ref d6(Q6[31:0],  data_writeReg[31:0] , clock, en1[6], ctrl_reset);
	dffe_ref d7(Q7[31:0],  data_writeReg[31:0] , clock, en1[7], ctrl_reset);
	dffe_ref d8(Q8[31:0],  data_writeReg[31:0] , clock, en1[8], ctrl_reset);
	dffe_ref d9(Q9[31:0],  data_writeReg[31:0] , clock, en1[9], ctrl_reset);
	dffe_ref d10(Q10[31:0],data_writeReg[31:0] , clock, en1[10], ctrl_reset);
	dffe_ref d11(Q11[31:0],data_writeReg[31:0] , clock, en1[11], ctrl_reset);
	dffe_ref d12(Q12[31:0],data_writeReg[31:0] , clock, en1[12], ctrl_reset);
	dffe_ref d13(Q13[31:0],data_writeReg[31:0] , clock, en1[13], ctrl_reset);
	dffe_ref d14(Q14[31:0],data_writeReg[31:0] , clock, en1[14], ctrl_reset);
	dffe_ref d15(Q15[31:0],data_writeReg[31:0] , clock, en1[15], ctrl_reset);
	dffe_ref d16(Q16[31:0],data_writeReg[31:0] , clock, en1[16], ctrl_reset);
	dffe_ref d17(Q17[31:0],data_writeReg[31:0] , clock, en1[17], ctrl_reset);
	dffe_ref d18(Q18[31:0],data_writeReg[31:0] , clock, en1[18], ctrl_reset);
	dffe_ref d19(Q19[31:0],data_writeReg[31:0] , clock, en1[19], ctrl_reset);
	dffe_ref d20(Q20[31:0],data_writeReg[31:0] , clock, en1[20], ctrl_reset);
	dffe_ref d21(Q21[31:0],data_writeReg[31:0] , clock, en1[21], ctrl_reset);
	dffe_ref d22(Q22[31:0],data_writeReg[31:0] , clock, en1[22], ctrl_reset);
	dffe_ref d23(Q23[31:0],data_writeReg[31:0] , clock, en1[23], ctrl_reset);
	dffe_ref d24(Q24[31:0],data_writeReg[31:0] , clock, en1[24], ctrl_reset);
	dffe_ref d25(Q25[31:0],data_writeReg[31:0] , clock, en1[25], ctrl_reset);
	dffe_ref d26(Q26[31:0],data_writeReg[31:0] , clock, en1[26], ctrl_reset);
	dffe_ref d27(Q27[31:0],data_writeReg[31:0] , clock, en1[27], ctrl_reset);
	dffe_ref d28(Q28[31:0],data_writeReg[31:0] , clock, en1[28], ctrl_reset);
	dffe_ref d29(Q29[31:0],data_writeReg[31:0] , clock, en1[29], ctrl_reset);
	dffe_ref d30(Q30[31:0],data_writeReg[31:0] , clock, en1[30], ctrl_reset);
	dffe_ref d31(Q31[31:0],data_writeReg[31:0] , clock, en1[31], ctrl_reset);
  
 
 wire[31:0] read_enA;

 decoder_32to1 de2(ctrl_readRegA[4:0],read_enA[31:0]);



assign data_readRegA = read_enA[0] ? 32'b0 : 32'bz; ///Register 0 must always reads 0!!!! 
assign data_readRegA = read_enA[1] ? Q1 : 32'bz; 
assign data_readRegA = read_enA[2] ? Q2 : 32'bz; 
assign data_readRegA = read_enA[3] ? Q3 : 32'bz; 
assign data_readRegA = read_enA[4] ? Q4 : 32'bz; 
assign data_readRegA = read_enA[5] ? Q5 : 32'bz; 
assign data_readRegA = read_enA[6] ? Q6 : 32'bz; 
assign data_readRegA = read_enA[7] ? Q7 : 32'bz;  
assign data_readRegA = read_enA[8] ? Q8 : 32'bz; 
assign data_readRegA = read_enA[9] ? Q9 : 32'bz; 
assign data_readRegA = read_enA[10] ? Q10 : 32'bz; 
assign data_readRegA = read_enA[11] ? Q11 : 32'bz; 
assign data_readRegA = read_enA[12] ? Q12 : 32'bz; 
assign data_readRegA = read_enA[13] ? Q13 : 32'bz; 
assign data_readRegA = read_enA[14] ? Q14 : 32'bz; 
assign data_readRegA = read_enA[15] ? Q15 : 32'bz;  
assign data_readRegA = read_enA[16] ? Q16 : 32'bz; 
assign data_readRegA = read_enA[17] ? Q17 : 32'bz; 
assign data_readRegA = read_enA[18] ? Q18 : 32'bz; 
assign data_readRegA = read_enA[19] ? Q19 : 32'bz; 
assign data_readRegA = read_enA[20] ? Q20 : 32'bz; 
assign data_readRegA = read_enA[21] ? Q21 : 32'bz; 
assign data_readRegA = read_enA[22] ? Q22 : 32'bz; 
assign data_readRegA = read_enA[23] ? Q23 : 32'bz; 
assign data_readRegA = read_enA[24] ? Q24 : 32'bz; 
assign data_readRegA = read_enA[25] ? Q25 : 32'bz; 
assign data_readRegA = read_enA[26] ? Q26 : 32'bz; 
assign data_readRegA = read_enA[27] ? Q27 : 32'bz; 
assign data_readRegA = read_enA[28] ? Q28 : 32'bz; 
assign data_readRegA = read_enA[29] ? Q29 : 32'bz; 
assign data_readRegA = read_enA[30] ? Q30 : 32'bz; 
assign data_readRegA = read_enA[31] ? Q31 : 32'bz; 


 wire[31:0] read_enB;

 decoder_32to1 de3(ctrl_readRegB[4:0],read_enB[31:0]);


 
assign data_readRegB = read_enB[0] ? 32'b0 : 32'bz; 
assign data_readRegB = read_enB[1] ? Q1 : 32'bz; 
assign data_readRegB = read_enB[2] ? Q2 : 32'bz; 
assign data_readRegB = read_enB[3] ? Q3 : 32'bz; 
assign data_readRegB = read_enB[4] ? Q4 : 32'bz; 
assign data_readRegB = read_enB[5] ? Q5 : 32'bz; 
assign data_readRegB = read_enB[6] ? Q6 : 32'bz; 
assign data_readRegB = read_enB[7] ? Q7 : 32'bz;  
assign data_readRegB = read_enB[8] ? Q8 : 32'bz; 
assign data_readRegB = read_enB[9] ? Q9 : 32'bz; 
assign data_readRegB = read_enB[10] ? Q10 : 32'bz; 
assign data_readRegB = read_enB[11] ? Q11 : 32'bz; 
assign data_readRegB = read_enB[12] ? Q12 : 32'bz; 
assign data_readRegB = read_enB[13] ? Q13 : 32'bz; 
assign data_readRegB = read_enB[14] ? Q14 : 32'bz; 
assign data_readRegB = read_enB[15] ? Q15 : 32'bz;  
assign data_readRegB = read_enB[16] ? Q16 : 32'bz; 
assign data_readRegB = read_enB[17] ? Q17 : 32'bz; 
assign data_readRegB = read_enB[18] ? Q18 : 32'bz; 
assign data_readRegB = read_enB[19] ? Q19 : 32'bz; 
assign data_readRegB = read_enB[20] ? Q20 : 32'bz; 
assign data_readRegB = read_enB[21] ? Q21 : 32'bz; 
assign data_readRegB = read_enB[22] ? Q22 : 32'bz; 
assign data_readRegB = read_enB[23] ? Q23 : 32'bz; 
assign data_readRegB = read_enB[24] ? Q24 : 32'bz; 
assign data_readRegB = read_enB[25] ? Q25 : 32'bz; 
assign data_readRegB = read_enB[26] ? Q26 : 32'bz; 
assign data_readRegB = read_enB[27] ? Q27 : 32'bz; 
assign data_readRegB = read_enB[28] ? Q28 : 32'bz; 
assign data_readRegB = read_enB[29] ? Q29 : 32'bz; 
assign data_readRegB = read_enB[30] ? Q30 : 32'bz; 
assign data_readRegB = read_enB[31] ? Q31 : 32'bz; 
	
	
	

endmodule