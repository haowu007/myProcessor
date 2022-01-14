module AND_32bit(result_and,data_operandA, data_operandB);

   input [31:0] data_operandA;
	input data_operandB;	 
   
   output [31:0] result_and;
  


	

and(result_and[0],  data_operandA[0],data_operandB);and(result_and[16],  data_operandA[16],data_operandB);
and(result_and[1],  data_operandA[1],data_operandB);and(result_and[17],  data_operandA[17],data_operandB);
and(result_and[2],  data_operandA[2],data_operandB);and(result_and[18],  data_operandA[18],data_operandB);
and(result_and[3],  data_operandA[3],data_operandB);and(result_and[19],  data_operandA[19],data_operandB);
and(result_and[4],  data_operandA[4],data_operandB);and(result_and[20],  data_operandA[20],data_operandB);
and(result_and[5],  data_operandA[5],data_operandB);and(result_and[21],  data_operandA[21],data_operandB);
and(result_and[6],  data_operandA[6],data_operandB);and(result_and[22],  data_operandA[22],data_operandB);
and(result_and[7],  data_operandA[7],data_operandB);and(result_and[23],  data_operandA[23],data_operandB);
and(result_and[8],  data_operandA[8],data_operandB);and(result_and[24],  data_operandA[24],data_operandB);
and(result_and[9],  data_operandA[9],data_operandB);and(result_and[25],  data_operandA[25],data_operandB);
and(result_and[10],  data_operandA[10],data_operandB);and(result_and[26],  data_operandA[26],data_operandB);
and(result_and[11],  data_operandA[11],data_operandB);and(result_and[27],  data_operandA[27],data_operandB);
and(result_and[12],  data_operandA[12],data_operandB);and(result_and[28],  data_operandA[28],data_operandB);
and(result_and[13],  data_operandA[13],data_operandB);and(result_and[29],  data_operandA[29],data_operandB);
and(result_and[14],  data_operandA[14],data_operandB);and(result_and[30],  data_operandA[30],data_operandB);
and(result_and[15],  data_operandA[15],data_operandB);and(result_and[31],  data_operandA[31],data_operandB);


	
endmodule
