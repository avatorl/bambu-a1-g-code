; layer num/total_layer_count: {layer_num+1}/[total_layer_count]
; update layer progress
M73 L{layer_num+1}
M991 S0 P{layer_num} ;notify layer change
